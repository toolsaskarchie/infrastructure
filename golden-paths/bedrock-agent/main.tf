# A Bedrock AgentCore agent: a registry for its images, memory for its
# conversations, and a runtime that runs the developer's container.
#
# Images and memory are encrypted with a key this path creates, which the org's
# Encryption standard requires.
#
# Bring your own container. The runtime needs an image that already exists, so
# `container_image` is the one thing a developer must answer. The registry is
# built alongside and the runtime may pull from it, so after the first deploy a
# team pushes new versions there and redeploys with the new tag.

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18"
    }
  }
}

provider "aws" {
  region = var.region
}

# One customer-managed key for everything this agent keeps at rest: its images
# and its conversations.
module "kms" {
  source              = "terraform-aws-modules/kms/aws"
  version             = "4.2.1"
  description         = "${var.project} agent (${var.environment}) images and memory"
  enable_key_rotation = true
  tags                = var.tags
}

module "registry" {
  source      = "../../modules/aws/agent-registry"
  project     = var.project
  environment = var.environment
  kms_key_arn = module.kms.key_arn
  tags        = var.tags
}

module "memory" {
  source            = "../../modules/aws/agent-memory"
  project           = var.project
  environment       = var.environment
  event_expiry_days = var.memory_event_expiry_days
  kms_key_arn       = module.kms.key_arn
  tags              = var.tags
}

# Wired from the other two by reference: the runtime may pull from the registry
# and read and write the memory, and is told which memory is its own.
module "runtime" {
  source          = "../../modules/aws/agent-runtime"
  project         = var.project
  environment     = var.environment
  container_image = var.container_image
  model_id        = var.model_id
  registry_arn    = module.registry.repository_arn
  memory_id       = module.memory.memory_id
  memory_arn      = module.memory.memory_arn
  tags            = var.tags
}

variable "region" {
  description = "AWS region for this stack. AgentCore is not in every region."
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Application/product identifier."
  type        = string
}

variable "environment" {
  description = "Deployment tier."
  type        = string
  default     = "dev"
}

variable "container_image" {
  description = "The agent's image in ECR (linux/arm64), already pushed."
  type        = string
}

variable "model_id" {
  description = "Bedrock model the agent calls."
  type        = string
  default     = "us.anthropic.claude-sonnet-4-20250514-v1:0"
}

variable "memory_event_expiry_days" {
  description = "How long conversation events are kept, in days (7-365)."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Mandatory org tags."
  type        = map(string)
  default     = {}
}

output "agent_runtime_arn" {
  description = "What callers pass to InvokeAgentRuntime."
  value       = module.runtime.agent_runtime_arn
}

output "endpoint_name" {
  description = "The qualifier for this agent's endpoint."
  value       = module.runtime.endpoint_name
}

output "repository_url" {
  description = "Push new agent images here."
  value       = module.registry.repository_url
}

output "memory_id" {
  description = "The agent's conversation memory."
  value       = module.memory.memory_id
}
