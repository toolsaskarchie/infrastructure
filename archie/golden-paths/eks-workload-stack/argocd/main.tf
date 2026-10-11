# Helm chart `argo-cd` 10.10.2 from https://argoproj.github.io/argo-helm, imported by Archie.
# The chart stays upstream; this pins its version. Upgrading is a new version.
terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12"
    }
  }
}

resource "helm_release" "this" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = var.create_namespace
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "10.10.2"

  # Only what was set; Helm merges it over the chart's own defaults. An
  # untouched map is `{}`, dropped too: nothing to merge.
  values = [yamlencode({ for k, v in {
      "nameOverride" = var.nameOverride,
      "fullnameOverride" = var.fullnameOverride,
      "namespaceOverride" = var.namespaceOverride,
      "kubeVersionOverride" = var.kubeVersionOverride,
      "apiVersionOverrides" = var.apiVersionOverrides,
      "createAggregateRoles" = var.createAggregateRoles,
      "createClusterRoles" = var.createClusterRoles,
      "openshift" = var.openshift,
      "crds" = var.crds,
      "global" = var.global,
      "configs" = var.configs,
      "extraObjects" = var.extraObjects,
      "controller" = var.controller,
      "dex" = var.dex,
      "redis" = var.redis,
      "redis-ha" = var.redis_ha,
      "externalRedis" = var.externalRedis,
      "redisSecretInit" = var.redisSecretInit,
      "server" = var.server,
      "repoServer" = var.repoServer,
      "applicationSet" = var.applicationSet,
      "notifications" = var.notifications,
      "commitServer" = var.commitServer
  } : k => v if v != null && v != {} })]
}


variable "release_name" {
  description = "Name of the Helm release."
  type        = string
  default     = "argo-cd"
}

variable "namespace" {
  description = "Namespace the release is installed into."
  type        = string
  default     = "argo-cd"
}

variable "create_namespace" {
  description = "Create the namespace when it does not exist."
  type        = bool
  default     = true
}

variable "nameOverride" {
  description = "Chart value `nameOverride`. Chart default: 'argocd'"
  type        = any
  default     = null
}

variable "fullnameOverride" {
  description = "Chart value `fullnameOverride`. Chart default: ''"
  type        = any
  default     = null
}

variable "namespaceOverride" {
  description = "Chart value `namespaceOverride`. Chart default: ''"
  type        = any
  default     = null
}

variable "kubeVersionOverride" {
  description = "Chart value `kubeVersionOverride`. Chart default: ''"
  type        = any
  default     = null
}

variable "apiVersionOverrides" {
  description = "Chart value `apiVersionOverrides`. Chart default: {}"
  type        = any
  default     = {}
}

variable "createAggregateRoles" {
  description = "Chart value `createAggregateRoles`. Chart default: false"
  type        = any
  default     = null
}

variable "createClusterRoles" {
  description = "Chart value `createClusterRoles`. Chart default: true"
  type        = any
  default     = null
}

variable "openshift" {
  description = "Chart value `openshift`. Chart default: {'enabled': false}"
  type        = any
  default     = {}
}

variable "crds" {
  description = "Chart value `crds`. Chart default: {'install': true, 'keep': true, 'annotations': {'argocd.argoproj.io/sync-options': 'ServerSideApply=true'}, 'additionalLabels': {}}"
  type        = any
  default     = {}
}

variable "global" {
  description = "Chart value `global`. Chart default: {'domain': 'argocd.example.com', 'runtimeClassName': '', 'additionalLabels': {}, 'revisionHistoryLimit': 3, 'image': {'repository': 'quay.io/argoproj/argocd'..."
  type        = any
  default     = {}
}

variable "configs" {
  description = "Chart value `configs`. Chart default: {'cm': {'create': true, 'annotations': {}, 'application.instanceLabelKey': 'argocd.argoproj.io/instance', 'application.sync.impersonation.enabled': false, 'e..."
  type        = any
  default     = {}
}

variable "extraObjects" {
  description = "Chart value `extraObjects`. Chart default: []"
  type        = any
  default     = null
}

variable "controller" {
  description = "Chart value `controller`. Chart default: {'name': 'application-controller', 'replicas': 1, 'dynamicClusterDistribution': false, 'runtimeClassName': '', 'heartbeatTime': 10, 'revisionHistoryLimit': 5..."
  type        = any
  default     = {}
}

variable "dex" {
  description = "Chart value `dex`. Chart default: {'enabled': true, 'name': 'dex-server', 'extraArgs': [], 'runtimeClassName': '', 'metrics': {'enabled': false, 'service': {'annotations': {}, 'labels': {}, '..."
  type        = any
  default     = {}
}

variable "redis" {
  description = "Chart value `redis`. Chart default: {'enabled': true, 'name': 'redis', 'runtimeClassName': '', 'existingSecret': '', 'pdb': {'enabled': false, 'labels': {}, 'annotations': {}, 'minAvailable': '..."
  type        = any
  default     = {}
}

variable "redis_ha" {
  description = "Chart value `redis-ha`. Chart default: {'enabled': false, 'image': {'repository': 'ecr-public.aws.com/docker/library/redis', 'tag': '8.6.4-alpine'}, 'exporter': {'enabled': false, 'image': 'ghcr.i..."
  type        = any
  default     = {}
}

variable "externalRedis" {
  description = "Chart value `externalRedis`. Chart default: {'host': '', 'username': '', 'password': '', 'port': 6379, 'existingSecret': '', 'secretAnnotations': {}}"
  type        = any
  default     = {}
}

variable "redisSecretInit" {
  description = "Chart value `redisSecretInit`. Chart default: {'enabled': true, 'name': 'redis-secret-init', 'image': {'repository': '', 'tag': '', 'imagePullPolicy': ''}, 'extraArgs': [], 'imagePullSecrets': [], 'runti..."
  type        = any
  default     = {}
}

variable "server" {
  description = "Chart value `server`. Chart default: {'enabled': true, 'name': 'server', 'replicas': 1, 'runtimeClassName': '', 'autoscaling': {'enabled': false, 'minReplicas': 1, 'maxReplicas': 5, 'targetCPUUt..."
  type        = any
  default     = {}
}

variable "repoServer" {
  description = "Chart value `repoServer`. Chart default: {'name': 'repo-server', 'replicas': 1, 'runtimeClassName': '', 'autoscaling': {'enabled': false, 'minReplicas': 1, 'maxReplicas': 5, 'targetCPUUtilizationPer..."
  type        = any
  default     = {}
}

variable "applicationSet" {
  description = "Chart value `applicationSet`. Chart default: {'name': 'applicationset-controller', 'replicas': 1, 'runtimeClassName': '', 'pdb': {'enabled': false, 'labels': {}, 'annotations': {}, 'minAvailable': '', '..."
  type        = any
  default     = {}
}

variable "notifications" {
  description = "Chart value `notifications`. Chart default: {'enabled': true, 'name': 'notifications-controller', 'argocdUrl': '', 'runtimeClassName': '', 'pdb': {'enabled': false, 'labels': {}, 'annotations': {}, 'mi..."
  type        = any
  default     = {}
}

variable "commitServer" {
  description = "Chart value `commitServer`. Chart default: {'enabled': false, 'name': 'commit-server', 'runtimeClassName': '', 'image': {'repository': '', 'tag': '', 'imagePullPolicy': ''}, 'extraArgs': [], 'extraEnv..."
  type        = any
  default     = {}
}


output "release_name" {
  value = helm_release.this.name
}
output "namespace" {
  value = helm_release.this.namespace
}
output "status" {
  value = helm_release.this.status
}
output "chart_version" {
  value = helm_release.this.version
}
