# --- main.tf ---
# Governed wrapper around terraform-aws-modules/route53/aws//modules/records.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "5.0.0"

  zone_id = var.zone_id
  records = [
    {
      name = var.certificate_domain_name
      type = "A"
      alias = {
        name                   = var.cloudfront_distribution_domain_name
        zone_id                = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
      }
    },
    {
      name = var.certificate_domain_name
      type = "AAAA"
      alias = {
        name                   = var.cloudfront_distribution_domain_name
        zone_id                = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
      }
    }
  ]
}

# --- variables.tf ---
variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = null
}

variable "certificate_domain_name" {
  description = "The record name / FQDN for the alias records"
  type        = string
}

variable "cloudfront_distribution_domain_name" {
  description = "The CloudFront distribution domain the records point at"
  type        = string
}

# --- outputs.tf ---
output "route53_record_name" {
  description = "The name of the record"
  value       = module.this.route53_record_name
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.this.route53_record_fqdn
}