variable "project" {
  description = "Application/product identifier, used in resource names."
  type        = string
}

variable "environment" {
  description = "Environment tier (dev|staging|prod)."
  type        = string
}

variable "container_image" {
  description = "The agent's container image in ECR, e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-agent:v1. Must be built for linux/arm64 and already pushed."
  type        = string

  validation {
    condition     = can(regex("^[0-9]{12}\\.dkr\\.ecr\\.[a-z0-9-]+\\.amazonaws\\.com/[^:@]+([:@].+)?$", var.container_image))
    error_message = "AgentCore runs images from private ECR only: <account>.dkr.ecr.<region>.amazonaws.com/<repo>[:tag]."
  }
}

variable "model_id" {
  description = "Bedrock model the agent calls, passed to the container as MODEL_ID."
  type        = string
  default     = "us.anthropic.claude-sonnet-4-20250514-v1:0"
}

variable "server_protocol" {
  description = "How AgentCore talks to the container: HTTP, MCP or A2A."
  type        = string
  default     = "HTTP"

  validation {
    condition     = contains(["HTTP", "MCP", "A2A"], var.server_protocol)
    error_message = "server_protocol must be HTTP, MCP or A2A."
  }
}

variable "registry_arn" {
  description = "An ECR repository the agent may also pull from, so images pushed there later roll out without an IAM change."
  type        = string
  default     = null
}

variable "memory_id" {
  description = "AgentCore memory the agent uses, passed to the container as MEMORY_ID."
  type        = string
  default     = null
}

variable "memory_arn" {
  description = "The same memory, so the role may read and write it."
  type        = string
  default     = null
}

variable "environment_variables" {
  description = "Extra environment for the container. MODEL_ID, ENVIRONMENT and MEMORY_ID are set by the module."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Mandatory org tags."
  type        = map(string)
  default     = {}
}
