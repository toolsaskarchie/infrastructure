# Governed wrapper around terraform-aws-modules/kms/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/kms/aws"
  version = "4.2.1"

  create_external = var.create_external
  deletion_window_in_days = var.deletion_window_in_days
  key_hmac_users = var.key_hmac_users
  create_replica = var.create_replica
  create_replica_external = var.create_replica_external
  key_users = var.key_users
  key_statements = var.key_statements
  tags = var.tags
  custom_key_store_id = var.custom_key_store_id
  key_usage = var.key_usage
  key_symmetric_encryption_users = var.key_symmetric_encryption_users
  multi_region = var.multi_region
  description = var.description
  key_administrators = var.key_administrators
  key_service_users = var.key_service_users
  aliases = var.aliases
  enable_route53_dnssec = var.enable_route53_dnssec
  enable_key_rotation = var.enable_key_rotation
  is_enabled = var.is_enabled
  key_owners = var.key_owners
  key_service_roles_for_autoscaling = var.key_service_roles_for_autoscaling
  enable_default_policy = var.enable_default_policy
}


variable "create_external" {
  description = "Determines whether an external CMK (externally provided material) will be created or a standard CMK (AWS provided material)"
  type        = bool
  default     = false
}

variable "deletion_window_in_days" {
  description = "The waiting period, specified in number of days. After the waiting period ends, AWS KMS deletes the KMS key. If you specify a value, it must be between `7` and `30`, inclusive. If you do not specify a"
  type        = number
  default     = null
}

variable "key_hmac_users" {
  description = "A list of IAM ARNs for [key HMAC users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-users-crypto)"
  type        = list(string)
  default     = []
}

variable "create_replica" {
  description = "Determines whether a replica standard CMK will be created (AWS provided material)"
  type        = bool
  default     = false
}

variable "create_replica_external" {
  description = "Determines whether a replica external CMK will be created (externally provided material)"
  type        = bool
  default     = false
}

variable "key_users" {
  description = "A list of IAM ARNs for [key users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-users)"
  type        = list(string)
  default     = []
}

variable "key_statements" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
  type        = list(object({
    sid           = optional(string)
    actions       = optional(list(string))
    not_actions   = optional(list(string))
    effect        = optional(string)
    resources     = optional(list(string))
    not_resources = optional(list(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    condition = optional(list(object({
      test     = string
      values   = list(string)
      variable = string
    })))
  }))
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "custom_key_store_id" {
  description = "ID of the KMS Custom Key Store where the key will be stored instead of KMS (eg CloudHSM)."
  type        = string
  default     = null
}

variable "key_usage" {
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`. Defaults to `ENCRYPT_DECRYPT`"
  type        = string
  default     = null
}

variable "key_symmetric_encryption_users" {
  description = "A list of IAM ARNs for [key symmetric encryption users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-users-crypto)"
  type        = list(string)
  default     = []
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region (`true`) or regional (`false`) key. Defaults to `false`"
  type        = bool
  default     = false
}

variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default     = null
}

variable "key_administrators" {
  description = "A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators)"
  type        = list(string)
  default     = []
}

variable "key_service_users" {
  description = "A list of IAM ARNs for [key service users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-service-integration)"
  type        = list(string)
  default     = []
}

variable "aliases" {
  description = "A list of aliases to create. Note - due to the use of `toset()`, values must be static strings and not computed values"
  type        = list(string)
  default     = []
}

variable "enable_route53_dnssec" {
  description = "Determines whether the KMS policy used for Route53 DNSSEC signing is enabled"
  type        = bool
  default     = false
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled. Defaults to `true`"
  type        = bool
  default     = true
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled. Defaults to `true`"
  type        = bool
  default     = null
}

variable "key_owners" {
  description = "A list of IAM ARNs for those who will have full key permissions (`kms:*`)"
  type        = list(string)
  default     = []
}

variable "key_service_roles_for_autoscaling" {
  description = "A list of IAM ARNs for [AWSServiceRoleForAutoScaling roles](https://docs.aws.amazon.com/autoscaling/ec2/userguide/key-policy-requirements-EBS-encryption.html#policy-example-cmk-access)"
  type        = list(string)
  default     = []
}

variable "enable_default_policy" {
  description = "Specifies whether to enable the default key policy. Defaults to `true`"
  type        = bool
  default     = true
}


output "key_id" {
  description = "The globally unique identifier for the key"
  value       = module.this.key_id
}

output "key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.this.key_arn
}

output "key_region" {
  description = "The region for the key"
  value       = module.this.key_region
}
