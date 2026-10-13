# Governed wrapper around terraform-aws-modules/route53/aws//modules/records.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "5.0.0"

  zone_name = var.zone_name
  records = var.records
  zone_id = var.zone_id
}


variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = null
}

variable "records" {
  description = "List of objects of DNS records"
  type        = any
  default     = []
}

variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = null
}


output "route53_record_name" {
  description = "The name of the record"
  value       = module.this.route53_record_name
  sensitive   = true
}

output "route53_record_fqdn" {
  description = "FQDN built using the zone domain and name"
  value       = module.this.route53_record_fqdn
  sensitive   = true
}
