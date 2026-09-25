output "namespace" {
  description = "Namespace the workload runs in."
  value       = local.namespace
}

output "service_name" {
  description = "Kubernetes Service name."
  value       = kubernetes_service_v1.this.metadata[0].name
}

output "load_balancer_hostname" {
  description = "Hostname of the Service's load balancer — what a CDN origin or DNS record points at. Empty for ClusterIP."
  value       = try(kubernetes_service_v1.this.status[0].load_balancer[0].ingress[0].hostname, "")
}

output "url" {
  description = "HTTP address of the workload through its load balancer."
  value       = try("http://${kubernetes_service_v1.this.status[0].load_balancer[0].ingress[0].hostname}", "")
}

output "iam_role_arn" {
  description = "The IAM role the pods assume, when they were given AWS permissions."
  value       = try(aws_iam_role.pods[0].arn, "")
}

output "service_account_name" {
  description = "Service account the pods run as."
  value       = kubernetes_service_account_v1.this.metadata[0].name
}
