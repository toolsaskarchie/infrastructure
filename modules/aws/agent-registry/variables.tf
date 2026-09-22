variable "project" {
  description = "Application/product identifier, used in the repository name."
  type        = string
}

variable "environment" {
  description = "Environment tier (dev|staging|prod)."
  type        = string
}

variable "image_tag_mutability" {
  description = "MUTABLE lets a tag like `latest` be re-pushed; IMMUTABLE pins every tag to one image."
  type        = string
  default     = "MUTABLE"
}

variable "images_to_keep" {
  description = "How many images the lifecycle policy retains."
  type        = number
  default     = 20
}

variable "force_delete" {
  description = "Delete the repository even when it still holds images. Without it, destroying the stack fails once anything was pushed."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "Customer-managed key for images at rest. Null uses AES256."
  type        = string
  default     = null
}

variable "tags" {
  description = "Mandatory org tags."
  type        = map(string)
  default     = {}
}
