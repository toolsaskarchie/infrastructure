# Governed wrapper around terraform-aws-modules/cloudfront/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "6.7.1"

  tags = var.tags
  aliases = [var.certificate_domain_name]
  continuous_deployment_policy_id = var.continuous_deployment_policy_id
  default_cache_behavior = {
    target_origin_id = "app"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET","HEAD","OPTIONS","PUT","POST","PATCH","DELETE"]
    cached_methods = ["GET","HEAD"]
    cache_policy_id = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
    origin_request_policy_id = "b689b0a8-53d0-40ab-baf2-68738e2966ac"
  }
  vpc_origin = var.vpc_origin
  create_monitoring_subscription = var.create_monitoring_subscription
  enable_v2_logging = var.enable_v2_logging
  web_acl_id = var.web_acl_id
  connection_function_association_id = var.connection_function_association_id
  is_ipv6_enabled = var.is_ipv6_enabled
  origin = {
    app = {
      domain_name = var.origin_domain_name
      origin_id = "app"
      custom_origin_config = {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = ["TLSv1.2"]
      }
    }
  }
  create_connection_function = var.create_connection_function
  connection_function_name = var.connection_function_name
  anycast_ip_list_id = var.anycast_ip_list_id
  viewer_certificate = {
    acm_certificate_arn = var.acm_certificate_arn
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "origin_domain_name" {
  description = "The origin host to forward to (e.g. a Lambda function URL host, no scheme)"
  type        = string
}

variable "certificate_domain_name" {
  description = "The custom domain used as the CNAME alias"
  type        = string
}

variable "acm_certificate_arn" {
  description = "An ACM certificate ARN in us-east-1"
  type        = string
}

variable "continuous_deployment_policy_id" {
  description = "Identifier of a continuous deployment policy. This argument should only be set on a production distribution"
  type        = string
  default     = null
}

variable "vpc_origin" {
  description = "Map of CloudFront VPC origins"
  type        = map(object({
    arn                    = string
    http_port              = number
    https_port             = number
    name                   = optional(string)
    origin_protocol_policy = string
    origin_ssl_protocols = object({
      items    = optional(list(string), ["TLSv1.2"])
      quantity = optional(number, 1)
    })
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    tags = optional(map(string), {})
  }))
  default     = null
}

variable "create_monitoring_subscription" {
  description = "If enabled, the resource for monitoring subscription will created"
  type        = bool
  default     = false
}

variable "enable_v2_logging" {
  description = "Whether to enable v2 logging for the CloudFront distribution"
  type        = bool
  default     = false
}

variable "web_acl_id" {
  description = "If you're using AWS WAF to filter CloudFront requests, the Id of the AWS WAF web ACL that is associated with the distribution. The WAF Web ACL must exist in the WAF Global (CloudFront) region and the "
  type        = string
  default     = null
}

variable "connection_function_association_id" {
  description = "Identifier of the connection function to associate with the distribution"
  type        = string
  default     = null
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution"
  type        = bool
  default     = true
}

variable "create_connection_function" {
  description = "Controls whether to create a CloudFront connection function"
  type        = bool
  default     = false
}

variable "connection_function_name" {
  description = "The name of the CloudFront connection function"
  type        = string
  default     = null
}

variable "anycast_ip_list_id" {
  description = "ID of the Anycast static IP list that is associated with the distribution"
  type        = string
  default     = null
}


output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = module.this.cloudfront_distribution_hosted_zone_id
}

output "connection_function_id" {
  description = "ID of the connection function"
  value       = module.this.connection_function_id
}

output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = module.this.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = module.this.cloudfront_distribution_arn
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.this.cloudfront_distribution_domain_name
}

output "cloudfront_monitoring_subscription_id" {
  description = " The ID of the CloudFront monitoring subscription, which corresponds to the `distribution_id`."
  value       = module.this.cloudfront_monitoring_subscription_id
}

output "connection_function_arn" {
  description = "ARN of the connection function"
  value       = module.this.connection_function_arn
}