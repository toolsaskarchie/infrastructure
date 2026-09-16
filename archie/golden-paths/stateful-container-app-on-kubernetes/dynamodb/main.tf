# Governed wrapper around terraform-aws-modules/dynamodb-table/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "5.5.1"

  ttl_enabled = var.ttl_enabled
  server_side_encryption_kms_key_arn = var.server_side_encryption_kms_key_arn
  attributes = var.attributes
  read_capacity = var.read_capacity
  create_table = var.create_table
  tags = var.tags
  range_key = var.range_key
  billing_mode = var.billing_mode
  server_side_encryption_enabled = var.server_side_encryption_enabled
  timeouts = var.timeouts
  restore_source_name = var.restore_source_name
  name = var.name
  hash_key = var.hash_key
  point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
  write_capacity = var.write_capacity
  autoscaling_enabled = var.autoscaling_enabled
  deletion_protection_enabled = var.deletion_protection_enabled
  ttl_attribute_name = var.ttl_attribute_name
  stream_enabled = var.stream_enabled
}


variable "ttl_enabled" {
  description = "Indicates whether ttl is enabled"
  type        = bool
  default     = false
}

variable "server_side_encryption_kms_key_arn" {
  description = "The ARN of the CMK that should be used for the AWS KMS encryption. This attribute should only be specified if the key is different from the default DynamoDB CMK, alias/aws/dynamodb."
  type        = string
  default     = null
}

variable "attributes" {
  description = "List of nested attribute definitions. Only required for hash_key and range_key attributes. Each attribute has two properties: name - (Required) The name of the attribute, type - (Required) Attribute t"
  type        = list(map(string))
  default     = []
}

variable "read_capacity" {
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "create_table" {
  description = "Controls if DynamoDB table and associated resources are created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "range_key" {
  description = "The attribute to use as the range (sort) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "billing_mode" {
  description = "Controls how you are billed for read/write throughput and how you manage capacity. The valid values are PROVISIONED or PAY_PER_REQUEST"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "server_side_encryption_enabled" {
  description = "Whether or not to enable encryption at rest using an AWS managed KMS customer master key (CMK)"
  type        = bool
  default     = false
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts"
  type        = map(string)
  default     = {
    create = "10m"
    delete = "10m"
    update = "60m"
  }
}

variable "restore_source_name" {
  description = "Name of the table to restore. Must match the name of an existing table."
  type        = string
  default     = null
}

variable "name" {
  description = "Name of the DynamoDB table"
  type        = string
  default     = null
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key. Must also be defined as an attribute"
  type        = string
  default     = null
}

variable "point_in_time_recovery_enabled" {
  description = "Whether to enable point-in-time recovery"
  type        = bool
  default     = false
}

variable "write_capacity" {
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
  type        = number
  default     = null
}

variable "autoscaling_enabled" {
  description = "Whether or not to enable autoscaling. See note in README about this setting"
  type        = bool
  default     = false
}

variable "deletion_protection_enabled" {
  description = "Enables deletion protection for table"
  type        = bool
  default     = null
}

variable "ttl_attribute_name" {
  description = "The name of the table attribute to store the TTL timestamp in"
  type        = string
  default     = ""
}

variable "stream_enabled" {
  description = "Indicates whether Streams are to be enabled (true) or disabled (false)."
  type        = bool
  default     = false
}


output "dynamodb_table_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.this.dynamodb_table_arn
}

output "dynamodb_table_id" {
  description = "ID of the DynamoDB table"
  value       = module.this.dynamodb_table_id
}

output "dynamodb_table_stream_arn" {
  description = "The ARN of the Table Stream"
  value       = module.this.dynamodb_table_stream_arn
}

output "dynamodb_table_replica_arns" {
  description = "Map of the Table replicas ARNs"
  value       = module.this.dynamodb_table_replica_arns
}

output "dynamodb_table_replica_stream_arns" {
  description = "Map of the Table replicas stream ARNs"
  value       = module.this.dynamodb_table_replica_stream_arns
}
