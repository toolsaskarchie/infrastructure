
terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}




variable "project_name" {
  description = "Tag prefix and resource name root."
  type        = string
  default     = "myapp"
}

variable "environment" {
  description = "Environment label (dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "image" {
  description = "Container image to deploy (e.g., nginx:latest, myapp:v1.0.0)."
  type        = string
  default     = "nginx:latest"
}

variable "container_port" {
  description = "Port the container listens on."
  type        = number
  default     = 80
  validation {
    condition     = var.container_port > 0 && var.container_port <= 65535
    error_message = "Container port must be between 1 and 65535."
  }
}

variable "replicas" {
  description = "Number of pod replicas to run."
  type        = number
  default     = 2
  validation {
    condition     = var.replicas > 0 && var.replicas <= 100
    error_message = "Replica count must be between 1 and 100."
  }
}

variable "namespace_name" {
  description = "Kubernetes namespace (leave empty to use default namespace)."
  type        = string
  default     = ""
}

variable "service_type" {
  description = "Kubernetes service type for exposure."
  type        = string
  default     = "LoadBalancer"
  validation {
    condition     = contains(["LoadBalancer", "ClusterIP", "NodePort"], var.service_type)
    error_message = "Service type must be LoadBalancer, ClusterIP, or NodePort."
  }
}

variable "health_check_path" {
  description = "HTTP path for readiness probe."
  type        = string
  default     = "/"
}

variable "cpu_request" {
  description = "CPU resource request per pod."
  type        = string
  default     = "100m"
}

variable "memory_request" {
  description = "Memory resource request per pod."
  type        = string
  default     = "128Mi"
}

variable "cpu_limit" {
  description = "CPU resource limit per pod."
  type        = string
  default     = "500m"
}

variable "memory_limit" {
  description = "Memory resource limit per pod."
  type        = string
  default     = "256Mi"
}

variable "labels" {
  description = "Additional labels to apply to all resources."
  type        = map(string)
  default     = {}
}




locals {
  common_labels = merge(
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "archie"
    },
    var.labels,
  )
  
  namespace = var.namespace_name != "" ? var.namespace_name : "default"
  create_namespace = var.namespace_name != "" && var.namespace_name != "default"
  
  app_name = "${var.project_name}-${var.environment}"
}

resource "kubernetes_namespace" "this" {
  count = local.create_namespace ? 1 : 0
  
  metadata {
    name   = local.namespace
    labels = local.common_labels
  }
}

resource "kubernetes_deployment" "this" {
  metadata {
    name      = local.app_name
    namespace = local.namespace
    labels    = local.common_labels
  }
  
  spec {
    replicas = var.replicas
    
    selector {
      match_labels = {
        app = local.app_name
      }
    }
    
    template {
      metadata {
        labels = merge(
          local.common_labels,
          {
            app = local.app_name
          }
        )
      }
      
      spec {
        container {
          name  = "app"
          image = var.image
          
          port {
            container_port = var.container_port
            protocol       = "TCP"
          }
          
          resources {
            requests = {
              cpu    = var.cpu_request
              memory = var.memory_request
            }
            limits = {
              cpu    = var.cpu_limit
              memory = var.memory_limit
            }
          }
          
          readiness_probe {
            http_get {
              path = var.health_check_path
              port = var.container_port
            }
            initial_delay_seconds = 10
            period_seconds        = 5
            timeout_seconds       = 3
            success_threshold     = 1
            failure_threshold     = 3
          }
          
          liveness_probe {
            http_get {
              path = var.health_check_path
              port = var.container_port
            }
            initial_delay_seconds = 30
            period_seconds        = 10
            timeout_seconds       = 5
            success_threshold     = 1
            failure_threshold     = 3
          }
        }
      }
    }
  }
  
  depends_on = [kubernetes_namespace.this]
}

resource "kubernetes_service" "this" {
  metadata {
    name      = local.app_name
    namespace = local.namespace
    labels    = local.common_labels
  }
  
  spec {
    type = var.service_type
    
    selector = {
      app = local.app_name
    }
    
    port {
      name        = "http"
      port        = 80
      target_port = var.container_port
      protocol    = "TCP"
    }
  }
  
  depends_on = [kubernetes_deployment.this]
}




output "deployment_name" {
  description = "Name of the Kubernetes deployment"
  value       = kubernetes_deployment.this.metadata[0].name
}

output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service.this.metadata[0].name
}

output "namespace" {
  description = "Namespace where resources are deployed"
  value       = local.namespace
}

output "service_type" {
  description = "Type of the Kubernetes service"
  value       = kubernetes_service.this.spec[0].type
}

output "service_port" {
  description = "External port of the service"
  value       = kubernetes_service.this.spec[0].port[0].port
}

output "container_port" {
  description = "Internal container port"
  value       = var.container_port
}

output "replicas" {
  description = "Number of pod replicas"
  value       = kubernetes_deployment.this.spec[0].replicas
}

output "image" {
  description = "Container image being deployed"
  value       = var.image
}

output "load_balancer_ingress" {
  description = "LoadBalancer ingress points (when service_type is LoadBalancer)"
  value       = var.service_type == "LoadBalancer" ? kubernetes_service.this.status[0].load_balancer[0].ingress : []
}