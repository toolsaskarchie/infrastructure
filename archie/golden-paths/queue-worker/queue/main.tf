# Governed wrapper around terraform-aws-modules/sqs/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/sqs/aws"
  version = "5.2.2"

  dlq_sqs_managed_sse_enabled = var.dlq_sqs_managed_sse_enabled
  redrive_allow_policy = var.redrive_allow_policy
  kms_master_key_id = var.kms_master_key_id
  name = var.name
  dlq_name = var.dlq_name
  create_dlq_queue_policy = var.create_dlq_queue_policy
  sqs_managed_sse_enabled = var.sqs_managed_sse_enabled
  create_queue_policy = var.create_queue_policy
  dlq_kms_master_key_id = var.dlq_kms_master_key_id
  create_dlq = var.create_dlq
  create_dlq_redrive_allow_policy = var.create_dlq_redrive_allow_policy
  tags = var.tags
  redrive_policy = var.redrive_policy
}


variable "dlq_sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "redrive_allow_policy" {
  description = "The JSON policy to set up the Dead Letter Queue redrive permission, see AWS docs"
  type        = any
  default     = {}
}

variable "kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name"
  type        = string
  default     = null
}

variable "dlq_name" {
  description = "This is the human-readable name of the queue. If omitted, Terraform will assign a random name"
  type        = string
  default     = null
}

variable "create_dlq_queue_policy" {
  description = "Whether to create SQS queue policy"
  type        = bool
  default     = false
}

variable "sqs_managed_sse_enabled" {
  description = "Boolean to enable server-side encryption (SSE) of message content with SQS-owned encryption keys"
  type        = bool
  default     = true
}

variable "create_queue_policy" {
  description = "Whether to create SQS queue policy"
  type        = bool
  default     = false
}

variable "dlq_kms_master_key_id" {
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK"
  type        = string
  default     = null
}

variable "create_dlq" {
  description = "Determines whether to create SQS dead letter queue"
  type        = bool
  default     = false
}

variable "create_dlq_redrive_allow_policy" {
  description = "Determines whether to create a redrive allow policy for the dead letter queue"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "redrive_policy" {
  description = "The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ('5')"
  type        = any
  default     = {}
}


output "dead_letter_queue_name" {
  description = "The name of the SQS queue"
  value       = module.this.dead_letter_queue_name
}

output "queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.this.queue_arn
}

output "dead_letter_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.this.dead_letter_queue_id
}

output "queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = module.this.queue_id
}

output "queue_name" {
  description = "The name of the SQS queue"
  value       = module.this.queue_name
}

output "dead_letter_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = module.this.dead_letter_queue_arn
}

output "dead_letter_queue_url" {
  description = "Same as `dead_letter_queue_id`: The URL for the created Amazon SQS queue"
  value       = module.this.dead_letter_queue_url
}

output "queue_url" {
  description = "Same as `queue_id`: The URL for the created Amazon SQS queue"
  value       = module.this.queue_url
}
