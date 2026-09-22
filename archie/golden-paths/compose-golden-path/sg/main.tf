# Governed wrapper around terraform-aws-modules/security-group/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  vpc_id = var.vpc_id
  timeouts = var.timeouts
  vpc_associations = var.vpc_associations
  description = var.description
  ingress_rules = var.ingress_rules
  egress_rules = var.egress_rules
  enable_exclusive_rules = var.enable_exclusive_rules
  tags = var.tags
  name = var.name
}


variable "vpc_id" {
  description = "ID of the VPC where the security group is created"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Create and delete timeout configurations for the security group"
  type        = object({
    create = optional(string)
    delete = optional(string)
  })
  default     = null
}

variable "vpc_associations" {
  description = "Map of VPC IDs to associate the security group to"
  type        = map(object({
    vpc_id = string
  }))
  default     = {}
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = null
}

variable "ingress_rules" {
  description = "Map of ingress rules to add to the security group"
  type        = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default     = {}
}

variable "egress_rules" {
  description = "Map of egress rules to add to the security group"
  type        = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(number)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(number)
  }))
  default     = {}
}

variable "enable_exclusive_rules" {
  description = "Whether to enforce that only the rules declared by this module exist on the security group. When true, out-of-band rules added via the AWS console or other Terraform configurations will be reverted on"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name of security group"
  type        = string
  default     = ""
}


output "arn" {
  description = "The ARN of the security group"
  value       = module.this.arn
}

output "vpc_id" {
  description = "The VPC ID"
  value       = module.this.vpc_id
}

output "name" {
  description = "The name of the security group"
  value       = module.this.name
}

output "id" {
  description = "The ID of the security group"
  value       = module.this.id
}

output "owner_id" {
  description = "The owner ID"
  value       = module.this.owner_id
}
