# One application container on an existing Kubernetes cluster: its namespace,
# Deployment, Service, service account and — only when it needs AWS — an IAM
# role the pods assume through the cluster's OIDC provider (IRSA).
#
# The container is the developer's; this module does not build or push it.
# `image` must already be in a registry the cluster's nodes can pull from.
#
# No provider configuration here: the platform supplies the cluster connection
# (endpoint, CA, token) when it deploys onto a cluster, and AWS credentials for
# the account.

terraform {
  required_version = ">= 1.6"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

locals {
  # Never claim a namespace this workload did not make: destroying the workload
  # would take everything else in it down too.
  builtin_namespaces = ["default", "kube-system", "kube-public", "kube-node-lease"]
  ns_name            = var.namespace != "" ? var.namespace : var.name
  create_namespace   = var.create_namespace && !contains(local.builtin_namespaces, local.ns_name)
  namespace          = local.create_namespace ? kubernetes_namespace_v1.this[0].metadata[0].name : local.ns_name

  # The pods get an AWS identity only when they were given something to do with it.
  wants_aws = length(var.iam_statements) > 0
  # ...and a Kubernetes API identity only when they were granted something there.
  wants_api   = length(var.api_access) > 0
  config_name = var.config_map_name != "" ? var.config_map_name : "${var.name}-config"
  has_config  = length(var.config_files) > 0
  labels      = merge(var.labels, { "app.kubernetes.io/name" = var.name })
  oidc_host   = replace(var.oidc_provider_arn, "/^arn:[^:]+:iam::[0-9]+:oidc-provider\\//", "")

  # A repository URL with no tag or digest means its :latest image.
  tagged       = can(regex("[:@][^/]*$", var.image))
  image        = local.tagged ? var.image : "${var.image}:latest"
  floating_tag = !local.tagged || endswith(var.image, ":latest")
}

resource "kubernetes_namespace_v1" "this" {
  count = local.create_namespace ? 1 : 0
  metadata {
    name   = local.ns_name
    labels = var.labels
  }
}

# ── AWS identity for the pods (IRSA), only when asked for ────────────────────

resource "aws_iam_role" "pods" {
  count = local.wants_aws ? 1 : 0
  name  = "${var.name}-pods"
  tags  = var.tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Federated = var.oidc_provider_arn }
      Action    = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.oidc_host}:sub" = "system:serviceaccount:${local.namespace}:${var.name}"
          "${local.oidc_host}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  lifecycle {
    precondition {
      condition     = var.oidc_provider_arn != ""
      error_message = "iam_statements grants the pods AWS access, which needs the cluster's oidc_provider_arn."
    }
  }
}

resource "aws_iam_role_policy" "pods" {
  count = local.wants_aws ? 1 : 0
  name  = "${var.name}-access"
  role  = aws_iam_role.pods[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [for s in var.iam_statements : {
      Effect   = "Allow"
      Action   = s.actions
      Resource = s.resources
    }]
  })
}

resource "kubernetes_service_account_v1" "this" {
  metadata {
    name        = var.name
    namespace   = local.namespace
    labels      = local.labels
    annotations = local.wants_aws ? { "eks.amazonaws.com/role-arn" = aws_iam_role.pods[0].arn } : {}
  }
  automount_service_account_token = local.wants_aws || local.wants_api
}

# ── files and API access the app is given ───────────────────────────────────

# Files the app READS, mounted read-only — data kept out of the image, changed
# without a rebuild.
resource "kubernetes_config_map_v1" "files" {
  count = local.has_config ? 1 : 0
  metadata {
    name      = local.config_name
    namespace = local.namespace
    labels    = local.labels
  }
  data = var.config_files
}

# What the pods may ask the Kubernetes API for, in their own namespace only.
resource "kubernetes_role_v1" "api" {
  count = local.wants_api ? 1 : 0
  metadata {
    name      = var.name
    namespace = local.namespace
    labels    = local.labels
  }
  dynamic "rule" {
    for_each = var.api_access
    content {
      api_groups     = rule.value.api_groups
      resources      = rule.value.resources
      resource_names = rule.value.resource_names
      verbs          = rule.value.verbs
    }
  }
}

resource "kubernetes_role_binding_v1" "api" {
  count = local.wants_api ? 1 : 0
  metadata {
    name      = var.name
    namespace = local.namespace
    labels    = local.labels
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.api[0].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.this.metadata[0].name
    namespace = local.namespace
  }
}

# ── the workload ─────────────────────────────────────────────────────────────

resource "kubernetes_deployment_v1" "this" {
  wait_for_rollout = var.wait_for_rollout

  metadata {
    name      = var.name
    namespace = local.namespace
    labels    = local.labels
  }

  spec {
    replicas = var.replicas
    selector {
      match_labels = { "app.kubernetes.io/name" = var.name }
    }

    template {
      metadata {
        labels = local.labels
      }
      spec {
        service_account_name = kubernetes_service_account_v1.this.metadata[0].name

        security_context {
          run_as_non_root = true
          run_as_user     = 10001
          fs_group        = 10001
        }

        container {
          name  = var.name
          image = local.image
          # A floating tag is re-pulled, so a restart runs the newest build.
          image_pull_policy = local.floating_tag ? "Always" : "IfNotPresent"

          port {
            container_port = var.container_port
          }

          # Who and where this pod is — the downward API, free and always true.
          env {
            name = "POD_NAME"
            value_from {
              field_ref { field_path = "metadata.name" }
            }
          }
          env {
            name = "POD_NAMESPACE"
            value_from {
              field_ref { field_path = "metadata.namespace" }
            }
          }
          env {
            name = "NODE_NAME"
            value_from {
              field_ref { field_path = "spec.nodeName" }
            }
          }

          dynamic "env" {
            for_each = var.env
            content {
              name  = env.key
              value = env.value
            }
          }

          resources {
            requests = { cpu = var.cpu_request, memory = var.memory_request }
            limits   = { cpu = var.cpu_limit, memory = var.memory_limit }
          }

          security_context {
            allow_privilege_escalation = false
            read_only_root_filesystem  = var.read_only_root_filesystem
            capabilities { drop = ["ALL"] }
          }

          readiness_probe {
            http_get {
              path = var.health_check_path
              port = var.container_port
            }
            initial_delay_seconds = 5
          }

          liveness_probe {
            http_get {
              path = var.health_check_path
              port = var.container_port
            }
            initial_delay_seconds = 15
          }

          # Most runtimes write here even with a read-only root filesystem.
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }

          dynamic "volume_mount" {
            for_each = local.has_config ? [1] : []
            content {
              name       = "config"
              mount_path = var.config_mount_path
              read_only  = true
            }
          }
        }

        volume {
          name = "tmp"
          empty_dir {}
        }

        dynamic "volume" {
          for_each = local.has_config ? [1] : []
          content {
            name = "config"
            config_map {
              name = kubernetes_config_map_v1.files[0].metadata[0].name
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "this" {
  metadata {
    name        = var.name
    namespace   = local.namespace
    labels      = local.labels
    annotations = var.service_annotations
  }
  spec {
    type     = var.service_type
    selector = { "app.kubernetes.io/name" = var.name }
    port {
      port        = 80
      target_port = var.container_port
    }
  }
  # A LoadBalancer's hostname is assigned after creation; wait for it so the
  # output below is an address, not "pending".
  wait_for_load_balancer = var.service_type == "LoadBalancer"
}
