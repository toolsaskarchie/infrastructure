variable "name" {
  description = "Workload name. Used for the Deployment, Service, service account and IAM role."
  type        = string
}

variable "namespace" {
  description = "Namespace to run in. Created unless it already exists as a built-in (default, kube-system, ...)."
  type        = string
  default     = "apps"
}

variable "create_namespace" {
  description = "Create the namespace, or deploy into one that already exists (another team's, or a shared one)."
  type        = bool
  default     = true
}

variable "image" {
  description = "Container image. A bare repository URL (an ECR repository's `repository_url`) means its `:latest` tag."
  type        = string
}

variable "wait_for_rollout" {
  description = <<-EOT
    Wait for the pods to become ready before the apply finishes.

    Off by default because the image is usually built AFTER the infrastructure
    exists: the registry has to be there before anything can be pushed to it.
    With this off the apply completes, Kubernetes keeps retrying the pull, and
    the pods start as soon as the image arrives. Turn it on when the image is
    already published and you want the apply to fail if the pods do not start.
  EOT
  type        = bool
  default     = false
}

variable "container_port" {
  description = "Port the application listens on inside the container."
  type        = number
  default     = 8080
}

variable "health_check_path" {
  description = "HTTP path the readiness and liveness probes call."
  type        = string
  default     = "/"
}

variable "env" {
  description = "Environment variables for the container — e.g. the name of the table it stores data in."
  type        = map(string)
  default     = {}
}

variable "replicas" {
  description = "Pod replica count."
  type        = number
  default     = 2
}

variable "cpu_request" {
  description = "CPU request per pod."
  type        = string
  default     = "250m"
}

variable "memory_request" {
  description = "Memory request per pod."
  type        = string
  default     = "256Mi"
}

variable "cpu_limit" {
  description = "CPU limit per pod."
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory limit per pod."
  type        = string
  default     = "512Mi"
}

variable "read_only_root_filesystem" {
  description = "Run with a read-only root filesystem. /tmp is always writable."
  type        = bool
  default     = true
}

variable "service_type" {
  description = "How the Service is exposed: LoadBalancer (reachable, e.g. as a CDN origin) or ClusterIP (in-cluster only)."
  type        = string
  default     = "LoadBalancer"
}

variable "service_annotations" {
  description = "Annotations on the Service, e.g. to choose an NLB or an internal load balancer."
  type        = map(string)
  default     = {}
}

variable "oidc_provider_arn" {
  description = "The cluster's IAM OIDC provider ARN (terraform-aws-modules/eks output `oidc_provider_arn`). Needed only when `iam_statements` grants the pods AWS access."
  type        = string
  default     = ""
}

variable "iam_statements" {
  description = "AWS permissions the pods need, e.g. [{actions = [\"dynamodb:GetItem\", \"dynamodb:PutItem\"], resources = [<table arn>]}]. Empty = the pods get no AWS identity."
  type = list(object({
    actions   = list(string)
    resources = list(string)
  }))
  default = []
}

variable "labels" {
  description = "Labels added to every object (the org's mandatory labels)."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags on the AWS resources this module creates (the IAM role)."
  type        = map(string)
  default     = {}
}
