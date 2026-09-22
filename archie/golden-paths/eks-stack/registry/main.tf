# Governed wrapper around terraform-aws-modules/ecr/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "3.2.0"

  tags = var.tags
  create_repository = var.create_repository
  create_registry_replication_configuration = var.create_registry_replication_configuration
  manage_registry_scanning_configuration = var.manage_registry_scanning_configuration
  create_registry_policy = var.create_registry_policy
  registry_pull_through_cache_rules = var.registry_pull_through_cache_rules
  repository_encryption_type = var.repository_encryption_type
  create_repository_policy = var.create_repository_policy
  repository_name = var.repository_name
  create_lifecycle_policy = var.create_lifecycle_policy
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "create_repository" {
  description = "Determines whether a repository will be created"
  type        = bool
  default     = true
}

variable "create_registry_replication_configuration" {
  description = "Determines whether a registry replication configuration will be created"
  type        = bool
  default     = false
}

variable "manage_registry_scanning_configuration" {
  description = "Determines whether the registry scanning configuration will be managed"
  type        = bool
  default     = false
}

variable "create_registry_policy" {
  description = "Determines whether a registry policy will be created"
  type        = bool
  default     = false
}

variable "registry_pull_through_cache_rules" {
  description = "List of pull through cache rules to create"
  type        = map(object({
    ecr_repository_prefix      = string
    upstream_registry_url      = string
    credential_arn             = optional(string)
    custom_role_arn            = optional(string)
    upstream_repository_prefix = optional(string)
    region                     = optional(string)
  }))
  default     = {}
}

variable "repository_encryption_type" {
  description = "The encryption type for the repository. Must be one of: `KMS` or `AES256`. Defaults to `AES256`"
  type        = string
  default     = null
}

variable "create_repository_policy" {
  description = "Determines whether a repository policy will be created"
  type        = bool
  default     = true
}

variable "repository_name" {
  description = "The name of the repository"
  type        = string
}

variable "create_lifecycle_policy" {
  description = "Determines whether a lifecycle policy will be created"
  type        = bool
  default     = true
}


output "repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = module.this.repository_registry_id
}

output "repository_name" {
  description = "Name of the repository"
  value       = module.this.repository_name
}

output "repository_arn" {
  description = "Full ARN of the repository"
  value       = module.this.repository_arn
}

output "repository_url" {
  description = "The URL of the repository"
  value       = module.this.repository_url
}
