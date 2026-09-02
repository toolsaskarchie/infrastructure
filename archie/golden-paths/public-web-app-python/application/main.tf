# Governed wrapper around terraform-aws-modules/lambda/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "8.8.0"

  s3_kms_key_id = var.s3_kms_key_id
  function_name = var.function_name
  create_role = var.create_role
  policy_name = var.policy_name
  create_package = var.create_package
  create_lambda_function_url = var.create_lambda_function_url
  cors = var.cors
  cloudwatch_logs_kms_key_id = var.cloudwatch_logs_kms_key_id
  memory_size = var.memory_size
  handler = var.handler
  create_current_version_allowed_triggers = var.create_current_version_allowed_triggers
  create_unqualified_alias_lambda_function_url = var.create_unqualified_alias_lambda_function_url
  layer_name = var.layer_name
  replacement_security_group_ids = var.replacement_security_group_ids
  create_unqualified_alias_allowed_triggers = var.create_unqualified_alias_allowed_triggers
  create_sam_metadata = var.create_sam_metadata
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  create_async_event_config = var.create_async_event_config
  create_function = var.create_function
  tags = var.tags
  create_unqualified_alias_async_event_config = var.create_unqualified_alias_async_event_config
  description = var.description
  runtime = var.runtime
  create_current_version_async_event_config = var.create_current_version_async_event_config
  cloudwatch_logs_deletion_protection_enabled = var.cloudwatch_logs_deletion_protection_enabled
  role_name = var.role_name
  timeout = var.timeout
  authorization_type = var.authorization_type
  kms_key_arn = var.kms_key_arn
  create_layer = var.create_layer
  vpc_subnet_ids = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
}


variable "s3_kms_key_id" {
  description = "Specifies a custom KMS key to use for S3 object encryption."
  type        = string
  default     = null
}

variable "function_name" {
  description = "A unique name for your Lambda Function"
  type        = string
}

variable "create_role" {
  description = "Controls whether IAM role for Lambda Function should be created"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "IAM policy name. It override the default value, which is the same as role_name"
  type        = string
  default     = null
}

variable "create_package" {
  description = "Controls whether Lambda package should be created"
  type        = bool
  default     = true
}

variable "create_lambda_function_url" {
  description = "Controls whether the Lambda Function URL resource should be created"
  type        = bool
  default     = false
}

variable "cors" {
  description = "CORS settings to be used by the Lambda Function URL"
  type        = any
  default     = {}
}

variable "cloudwatch_logs_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data."
  type        = string
  default     = null
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Valid value between 128 MB to 10,240 MB (10 GB), in 64 MB increments."
  type        = number
  default     = 128
}

variable "handler" {
  description = "Lambda Function entrypoint in your code"
  type        = string
  default     = ""
}

variable "create_current_version_allowed_triggers" {
  description = "Whether to allow triggers on current version of Lambda Function (this will revoke permissions from previous version because Terraform manages only current resources)"
  type        = bool
  default     = true
}

variable "create_unqualified_alias_lambda_function_url" {
  description = "Whether to use unqualified alias pointing to $LATEST version in Lambda Function URL"
  type        = bool
  default     = true
}

variable "layer_name" {
  description = "Name of Lambda Layer to create"
  type        = string
  default     = ""
}

variable "replacement_security_group_ids" {
  description = "(Optional) List of security group IDs to assign to orphaned Lambda function network interfaces upon destruction. replace_security_groups_on_destroy must be set to true to use this attribute."
  type        = list(string)
  default     = null
}

variable "create_unqualified_alias_allowed_triggers" {
  description = "Whether to allow triggers on unqualified alias pointing to $LATEST version"
  type        = bool
  default     = true
}

variable "create_sam_metadata" {
  description = "Controls whether the SAM metadata null resource should be created"
  type        = bool
  default     = false
}

variable "cloudwatch_logs_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653."
  type        = number
  default     = null
}

variable "create_async_event_config" {
  description = "Controls whether async event configuration for Lambda Function/Alias should be created"
  type        = bool
  default     = false
}

variable "create_function" {
  description = "Controls whether Lambda Function resource should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to resources."
  type        = map(string)
  default     = {}
}

variable "create_unqualified_alias_async_event_config" {
  description = "Whether to allow async event configuration on unqualified alias pointing to $LATEST version"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of your Lambda Function (or Layer)"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Lambda Function runtime"
  type        = string
  default     = ""
}

variable "create_current_version_async_event_config" {
  description = "Whether to allow async event configuration on current version of Lambda Function (this will revoke permissions from previous version because Terraform manages only current resources)"
  type        = bool
  default     = true
}

variable "cloudwatch_logs_deletion_protection_enabled" {
  description = "Whether to enable deletion protection for the log group."
  type        = bool
  default     = null
}

variable "role_name" {
  description = "Name of IAM role to use for Lambda Function"
  type        = string
  default     = null
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "authorization_type" {
  description = "The type of authentication that the Lambda Function URL uses. Set to 'AWS_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoi"
  type        = string
  default     = "NONE"
}

variable "kms_key_arn" {
  description = "The ARN of KMS key to use by your Lambda Function"
  type        = string
  default     = null
}

variable "create_layer" {
  description = "Controls whether Lambda Layer resource should be created"
  type        = bool
  default     = false
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}


output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.this.lambda_function_name
}

output "lambda_function_kms_key_arn" {
  description = "The ARN for the KMS encryption key of Lambda Function"
  value       = module.this.lambda_function_kms_key_arn
}

output "lambda_function_signing_profile_version_arn" {
  description = "ARN of the signing profile version"
  value       = module.this.lambda_function_signing_profile_version_arn
}

output "lambda_event_source_mapping_function_arn" {
  description = "The the ARN of the Lambda function the event source mapping is sending events to"
  value       = module.this.lambda_event_source_mapping_function_arn
}

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.this.lambda_function_arn
}

output "lambda_layer_arn" {
  description = "The ARN of the Lambda Layer with version"
  value       = module.this.lambda_layer_arn
}

output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = module.this.lambda_role_arn
}

output "lambda_role_name" {
  description = "The name of the IAM role created for the Lambda Function"
  value       = module.this.lambda_role_name
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = module.this.lambda_function_qualified_arn
}

output "lambda_function_qualified_invoke_arn" {
  description = "The Invoke ARN identifying your Lambda Function Version"
  value       = module.this.lambda_function_qualified_invoke_arn
}

output "lambda_role_unique_id" {
  description = "The unique id of the IAM role created for the Lambda Function"
  value       = module.this.lambda_role_unique_id
}

output "lambda_event_source_mapping_arn" {
  description = "The event source mapping ARN"
  value       = module.this.lambda_event_source_mapping_arn
}

output "lambda_function_signing_job_arn" {
  description = "ARN of the signing job"
  value       = module.this.lambda_function_signing_job_arn
}

output "lambda_function_url_id" {
  description = "The Lambda Function URL generated id"
  value       = module.this.lambda_function_url_id
}

output "lambda_layer_layer_arn" {
  description = "The ARN of the Lambda Layer without version"
  value       = module.this.lambda_layer_layer_arn
}

output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the Cloudwatch Log Group"
  value       = module.this.lambda_cloudwatch_log_group_arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = module.this.lambda_function_invoke_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the Cloudwatch Log Group"
  value       = module.this.lambda_cloudwatch_log_group_name
}

output "lambda_function_url" {
  description = "The URL of the Lambda Function URL"
  value       = module.this.lambda_function_url
}
