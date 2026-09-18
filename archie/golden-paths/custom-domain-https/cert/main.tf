# --- main.tf ---
# Governed wrapper around terraform-aws-modules/acm/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.1"

  validate_certificate = var.validate_certificate
  zone_id = var.zone_id
  validation_method = var.validation_method
  create_route53_records_only = var.create_route53_records_only
  key_algorithm = var.key_algorithm
  create_certificate = var.create_certificate
  domain_name = var.domain_name
  create_route53_records = var.create_route53_records
  tags = var.tags
}

# --- variables.tf ---
variable "validate_certificate" {
  description = "Whether to validate certificate by creating Route53 record"
  type        = bool
  default     = true
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record. Required when validating via Route53"
  type        = string
  default     = ""
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid. This parameter must not be set for certificates that were imported into ACM and then into Terraform."
  type        = string
  default     = null
}

variable "create_route53_records_only" {
  description = "Whether to create only Route53 records (e.g. using separate AWS provider)"
  type        = bool
  default     = false
}

variable "key_algorithm" {
  description = "Specifies the algorithm of the public and private key pair that your Amazon issued certificate uses to encrypt data"
  type        = string
  default     = null
}

variable "create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
  default     = true
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
  default     = ""
}

variable "create_route53_records" {
  description = "When validation is set to DNS, define whether to create the DNS records internally via Route53 or externally using any DNS provider"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

# --- outputs.tf ---
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.this.acm_certificate_arn
}

output "acm_certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-"
  value       = module.this.acm_certificate_domain_validation_options
}

output "validation_route53_record_fqdns" {
  description = "List of FQDNs built using the zone domain and name."
  value       = module.this.validation_route53_record_fqdns
}

output "distinct_domain_names" {
  description = "List of distinct domains names used for the validation."
  value       = module.this.distinct_domain_names
}

output "certificate_domain_name" {
  description = "The domain name for which the certificate was issued"
  value       = var.domain_name
}