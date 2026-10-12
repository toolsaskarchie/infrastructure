# Governed wrapper around terraform-aws-modules/acm/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.1"

  validate_certificate = var.validate_certificate
  zone_id = var.zone_id
  validation_method = var.validation_method
  distinct_domain_names = var.distinct_domain_names
  create_route53_records_only = var.create_route53_records_only
  acm_certificate_domain_validation_options = var.acm_certificate_domain_validation_options
  key_algorithm = var.key_algorithm
  create_certificate = var.create_certificate
  domain_name = var.domain_name
  create_route53_records = var.create_route53_records
  tags = var.tags
}


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
  validation {
    condition     = var.validation_method == null || contains(["DNS", "EMAIL"], var.validation_method)
    error_message = "validation_method must be one of: DNS, EMAIL."
  }
}

variable "distinct_domain_names" {
  description = "List of distinct domains and SANs (used when create_route53_records_only is set to true)"
  type        = list(string)
  default     = []
}

variable "create_route53_records_only" {
  description = "Whether to create only Route53 records (e.g. using separate AWS provider)"
  type        = bool
  default     = false
}

variable "acm_certificate_domain_validation_options" {
  description = "A list of domain_validation_options created by the ACM certificate to create required Route53 records from it (used when create_route53_records_only is set to true)"
  type        = any
  default     = {}
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


output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.this.acm_certificate_arn
  sensitive   = true
}

output "acm_certificate_domain_validation_options" {
  description = "A list of attributes to feed into other resources to complete certificate validation. Can have more than one element, e.g. if SANs are defined. Only set if DNS-"
  value       = module.this.acm_certificate_domain_validation_options
  sensitive   = true
}

output "validation_route53_record_fqdns" {
  description = "List of FQDNs built using the zone domain and name."
  value       = module.this.validation_route53_record_fqdns
  sensitive   = true
}

output "distinct_domain_names" {
  description = "List of distinct domains names used for the validation."
  value       = module.this.distinct_domain_names
  sensitive   = true
}

output "validation_domains" {
  description = "List of distinct domain validation options. This is useful if subject alternative names contain wildcards."
  value       = module.this.validation_domains
  sensitive   = true
}
