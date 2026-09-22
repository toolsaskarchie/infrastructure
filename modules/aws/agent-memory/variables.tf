variable "project" {
  description = "Application/product identifier."
  type        = string
}

variable "environment" {
  description = "Environment tier (dev|staging|prod)."
  type        = string
}

variable "event_expiry_days" {
  description = "How long conversation events are kept, in days (7-365)."
  type        = number
  default     = 30

  validation {
    condition     = var.event_expiry_days >= 7 && var.event_expiry_days <= 365
    error_message = "AgentCore keeps memory events for 7 to 365 days."
  }
}

variable "kms_key_arn" {
  description = "Customer-managed key for memory at rest. Null uses an AWS-owned key."
  type        = string
  default     = null
}

variable "tags" {
  description = "Mandatory org tags."
  type        = map(string)
  default     = {}
}
