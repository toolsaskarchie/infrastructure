# --- variables.tf ---
variable "project" {
  description = "Application/product identifier."
  type        = string
}
variable "environment" {
  description = "Environment tier (dev|staging|prod)."
  type        = string
}
variable "namespace" {
  description = "Namespace to deploy into."
  type        = string
}
variable "image" {
  description = "Fully-qualified container image."
  type        = string
}
variable "replicas" {
  description = "Pod replica count."
  type        = number
  # The per-tier values are a platform decision, not this module's: dev runs 2,
  # staging 3, prod 6. The default is the smallest, so a caller that says
  # nothing gets the cheapest thing that runs.
  default = 2
}
variable "cpu_request" {
  description = "CPU request per pod."
  type        = string
  default     = "250m"
}
variable "memory_request" {
  description = "Memory request per pod."
  type        = string
  default     = "512Mi"
}
variable "cpu_limit" {
  description = "CPU limit per pod."
  type        = string
  default     = "1"
}
variable "memory_limit" {
  description = "Memory limit per pod."
  type        = string
  default     = "1Gi"
}
variable "container_port" {
  description = "Port the app listens on."
  type        = number
  default     = 8080
}
variable "service_type" {
  description = "How the Service is exposed: LoadBalancer (public) or ClusterIP."
  type        = string
  # LoadBalancer, because this is the path that has actually WORKED. The
  # eks-k8s-demo that produced a reachable page used exactly this and read its
  # URL off the Service's ELB hostname; EKS's in-tree AWS cloud provider creates
  # that load balancer with nothing else installed.
  default = "LoadBalancer"
}

variable "ingress_enabled" {
  description = "Expose via an ALB Ingress. Requires the AWS Load Balancer Controller."
  type        = bool
  # FALSE, and this is a correction. The comment below the Ingress claimed it
  # matched the eks-k8s-demo; the demo uses a LoadBalancer Service. NOTHING in
  # this organisation installs the AWS Load Balancer Controller — not this
  # module, not the eks module, not the demo — so an `ingressClassName: alb`
  # object is created, never reconciled, and sits without an address forever
  # while Terraform reports success. Turn this on once the controller exists.
  default = false
}
variable "ingress_host" {
  description = "Hostname for the Ingress."
  type        = string
  # Empty is MEANINGFUL, not missing: the rule below reads
  # `host = var.ingress_host != "" ? var.ingress_host : null`, and a null host
  # matches any Host header — which is what makes the ALB's own DNS name work
  # without a DNS record existing first. Setting a hostname here without a
  # matching record makes the app unreachable, so empty is the right default.
  default = ""
}
variable "labels" {
  description = "Mandatory org labels."
  type        = map(string)
  # Which labels are mandatory is the org's call, not this module's, so it holds
  # no opinion — but it must not refuse to run for a caller that has no policy.
  default = {}
}

variable "ingress_scheme" {
  description = "ALB scheme for the Ingress: internet-facing (public demo) or internal (private)."
  type        = string
  default     = "internet-facing"
}

variable "create_namespace" {
  description = <<-EOT
    Create the namespace, or deploy into one that already exists.

    Defaults to true because most workloads want their own. Set it false to
    deploy alongside something already living there — two services sharing a
    team namespace is ordinary, and the second one must not try to create what
    the first already made.

    Ignored for Kubernetes' built-in namespaces, which every cluster ships with
    and no workload may claim.
  EOT
  type        = bool
  default     = true
}

# --- outputs.tf ---
output "namespace" {
  description = "Namespace the workload runs in (created here, or pre-existing)."
  value       = local.namespace
}
output "service_name" {
  description = "Service name."
  value       = kubernetes_service_v1.main.metadata[0].name
}

output "url" {
  description = "Public URL of the page. ELB hostname from the LoadBalancer Service, or the ALB when the Ingress is enabled."
  value = (
    var.ingress_enabled
    ? try("http://${kubernetes_ingress_v1.main[0].status[0].load_balancer[0].ingress[0].hostname}", "pending")
    : try("http://${kubernetes_service_v1.main.status[0].load_balancer[0].ingress[0].hostname}", "pending")
  )
}

output "alb_hostname" {
  description = "Public ALB hostname provisioned by the AWS Load Balancer Controller."
  value       = var.ingress_enabled ? try(kubernetes_ingress_v1.main[0].status[0].load_balancer[0].ingress[0].hostname, "pending") : null
}

# --- main.tf ---
locals {
  # NEVER CLAIM A NAMESPACE YOU DID NOT MAKE. This module created its namespace
  # unconditionally, which failed on `default` with
  #
  #     Error: namespaces "default" already exists
  #
  # and would have failed the same way on any namespace another team's workload
  # had already made. The failure is the mild half. Terraform destroys what it
  # creates, so had the apply succeeded, tearing this one app down would have
  # taken the namespace with it — and everything else running inside it. On
  # `default` that is most of the cluster.
  #
  # So: create it when it is ours to create, and otherwise just deploy into it.
  _builtin_namespaces = ["default", "kube-system", "kube-public", "kube-node-lease"]
  create_namespace    = var.create_namespace && !contains(local._builtin_namespaces, var.namespace)

  # Every resource below reads the namespace from HERE, not from the resource.
  # When we create it this carries the dependency; when we do not, there is
  # nothing to depend on because the namespace already exists.
  namespace = local.create_namespace ? kubernetes_namespace_v1.main[0].metadata[0].name : var.namespace
}

resource "kubernetes_namespace_v1" "main" {
  count = local.create_namespace ? 1 : 0

  metadata {
    name   = var.namespace
    labels = var.labels
  }
}

resource "kubernetes_deployment_v1" "main" {
  metadata {
    name      = var.project
    namespace = local.namespace
    labels    = var.labels
  }
  spec {
    replicas = var.replicas
    selector {
      match_labels = { app = var.project }
    }
    template {
      metadata {
        labels = merge(var.labels, { app = var.project })
      }
      spec {
        automount_service_account_token = false
        container {
          name  = var.project
          image = var.image
          port { container_port = var.container_port }
          resources {
            requests = {
              cpu    = var.cpu_request,
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit,
              memory = var.memory_limit
            }
          }
          liveness_probe {
            http_get {
              path = "/"
              port = var.container_port
            }
            initial_delay_seconds = 10
          }
          readiness_probe {
            http_get {
              path = "/"
              port = var.container_port
            }
            initial_delay_seconds = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "main" {
  metadata {
    name      = var.project
    namespace = local.namespace
    labels    = var.labels
  }
  spec {
    selector = { app = var.project }
    port {
      port        = 80
      target_port = var.container_port
    }
    type = var.service_type
  }
}

resource "kubernetes_network_policy_v1" "default_deny" {
  metadata {
    name      = "${var.project}-default-deny"
    namespace = local.namespace
  }
  spec {
    pod_selector {}
    policy_types = ["Ingress"]

    # Deny everything EXCEPT the port this app serves on. A bare deny-all with no
    # rule blocks the load balancer too, so the page this module exists to
    # publish would be unreachable the moment NetworkPolicy is actually enforced
    # — silently, because EKS's VPC CNI ignores policy unless enabled, so it
    # would work until the day someone turned enforcement on.
    ingress {
      ports {
        port     = var.container_port
        protocol = "TCP"
      }
    }
  }
}

# OPTIONAL ALB Ingress, off by default. The claim that this matched the
# eks-k8s-demo was wrong: that demo exposes a LoadBalancer Service and reads its
# ELB hostname. This path needs the AWS Load Balancer Controller, which nothing
# here installs, so it is gated behind ingress_enabled rather than assumed.
resource "kubernetes_ingress_v1" "main" {
  count = var.ingress_enabled ? 1 : 0
  metadata {
    name      = var.project
    namespace = local.namespace
    labels    = var.labels
    annotations = {
      "alb.ingress.kubernetes.io/scheme"           = var.ingress_scheme
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\":80}]"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/"
    }
  }

  spec {
    ingress_class_name = "alb"

    rule {
      host = var.ingress_host != "" ? var.ingress_host : null
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service_v1.main.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}