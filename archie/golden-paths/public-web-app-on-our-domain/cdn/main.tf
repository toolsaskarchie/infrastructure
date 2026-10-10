# Governed wrapper around terraform-aws-modules/cloudfront/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "6.7.1"

  tags = var.tags
  aliases = var.aliases
  continuous_deployment_policy_id = var.continuous_deployment_policy_id
  default_cache_behavior = var.default_cache_behavior
  vpc_origin = var.vpc_origin
  cache_policies = var.cache_policies
  cloudfront_functions = var.cloudfront_functions
  create_monitoring_subscription = var.create_monitoring_subscription
  enable_v2_logging = var.enable_v2_logging
  response_headers_policies = var.response_headers_policies
  web_acl_id = var.web_acl_id
  connection_function_association_id = var.connection_function_association_id
  is_ipv6_enabled = var.is_ipv6_enabled
  origin = var.origin
  create_connection_function = var.create_connection_function
  connection_function_name = var.connection_function_name
  origin_access_control = var.origin_access_control
  anycast_ip_list_id = var.anycast_ip_list_id
  viewer_certificate = var.viewer_certificate
  origin_request_policies = var.origin_request_policies
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "aliases" {
  description = "Extra CNAMEs (alternate domain names), if any, for this distribution"
  type        = list(string)
  default     = null
}

variable "continuous_deployment_policy_id" {
  description = "Identifier of a continuous deployment policy. This argument should only be set on a production distribution"
  type        = string
  default     = null
}

variable "default_cache_behavior" {
  description = "The default cache behavior for this distribution"
  type        = object({
    allowed_methods           = optional(list(string), ["GET", "HEAD", "OPTIONS"])
    cache_policy_id           = optional(string)
    cache_policy_key          = optional(string)
    cache_policy_name         = optional(string)
    cached_methods            = optional(list(string), ["GET", "HEAD"])
    compress                  = optional(bool, true)
    default_ttl               = optional(number)
    field_level_encryption_id = optional(string)
    forwarded_values = optional(object({
      cookies = object({
        forward           = optional(string, "none")
        whitelisted_names = optional(list(string))
      })
      headers                 = optional(list(string))
      query_string            = optional(bool, false)
      query_string_cache_keys = optional(list(string))
      }),
      {
        cookies = {
          forward = "none"
        }
        query_string = false
      }
    )
    function_association = optional(map(object({
      event_type   = optional(string)
      function_arn = optional(string)
      function_key = optional(string)
    })))
    grpc_config = optional(object({
      enabled = optional(bool)
    }))
    lambda_function_association = optional(map(object({
      event_type   = optional(string)
      include_body = optional(bool)
      lambda_arn   = string
    })))
    max_ttl                      = optional(number)
    min_ttl                      = optional(number)
    origin_request_policy_id     = optional(string)
    origin_request_policy_key    = optional(string)
    origin_request_policy_name   = optional(string)
    realtime_log_config_arn      = optional(string)
    response_headers_policy_id   = optional(string)
    response_headers_policy_key  = optional(string)
    response_headers_policy_name = optional(string)
    smooth_streaming             = optional(bool)
    target_origin_id             = string
    trusted_key_groups           = optional(list(string))
    trusted_signers              = optional(list(string))
    viewer_protocol_policy       = optional(string, "https-only")
  })
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

variable "cache_policies" {
  description = "Map of CloudFront cache policies"
  type        = map(object({
    name        = optional(string)
    comment     = optional(string)
    default_ttl = optional(number)
    max_ttl     = optional(number)
    min_ttl     = number
    parameters_in_cache_key_and_forwarded_to_origin = object({
      enable_accept_encoding_brotli = optional(bool)
      enable_accept_encoding_gzip   = optional(bool)
      cookies_config = object({
        cookie_behavior = string
        cookies = optional(object({
          items = list(string)
        }))
      })
      headers_config = object({
        header_behavior = string
        headers = optional(object({
          items = list(string)
        }))
      })
      query_strings_config = object({
        query_string_behavior = string
        query_strings = optional(object({
          items = list(string)
        }))
      })
    })
  }))
  default     = null
}

variable "cloudfront_functions" {
  description = "Map of CloudFront Function configurations. Key is used as default function name if 'name' not specified"
  type        = map(object({
    name                         = optional(string)
    runtime                      = optional(string, "cloudfront-js-2.0")
    comment                      = optional(string)
    publish                      = optional(bool)
    code                         = string
    key_value_store_associations = optional(list(string))
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

variable "response_headers_policies" {
  description = "Map of CloudFront response headers policies with their configurations"
  type        = map(object({
    name    = optional(string)
    comment = optional(string)
    cors_config = optional(object({
      access_control_allow_credentials = bool
      origin_override                  = bool
      access_control_allow_headers = object({
        items = list(string)
      })
      access_control_allow_methods = object({
        items = list(string)
      })
      access_control_allow_origins = object({
        items = list(string)
      })
      access_control_expose_headers = optional(object({
        items = list(string)
      }))
      access_control_max_age_sec = optional(number)
    }))
    custom_headers_config = optional(object({
      items = list(object({
        header   = string
        override = bool
        value    = string
      }))
    }))
    remove_headers_config = optional(object({
      items = list(object({
        header = string
      }))
    }))
    security_headers_config = optional(object({
      content_security_policy = optional(object({
        content_security_policy = string
        override                = bool
      }))
      content_type_options = optional(object({
        override = bool
      }))
      frame_options = optional(object({
        frame_option = string
        override     = bool
      }))
      referrer_policy = optional(object({
        referrer_policy = string
        override        = bool
      }))
      strict_transport_security = optional(object({
        access_control_max_age_sec = number
        override                   = bool
        include_subdomains         = optional(bool)
        preload                    = optional(bool)
      }))
      xss_protection = optional(object({
        mode_block = bool
        override   = bool
        protection = bool
        report_uri = optional(string)
      }))
    }))
    server_timing_headers_config = optional(object({
      enabled       = bool
      sampling_rate = number
    }))
  }))
  default     = null
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

variable "origin" {
  description = "One or more origins for this distribution (multiples allowed)"
  type        = map(object({
    connection_attempts = optional(number)
    connection_timeout  = optional(number)
    custom_header       = optional(map(string))
    custom_origin_config = optional(object({
      http_port                = number
      https_port               = number
      ip_address_type          = optional(string)
      origin_keepalive_timeout = optional(number)
      origin_read_timeout      = optional(number)
      origin_protocol_policy   = string
      origin_ssl_protocols     = optional(list(string), ["TLSv1.2"])
    }))
    domain_name               = string
    origin_access_control_key = optional(string)
    origin_access_control_id  = optional(string)
    origin_id                 = optional(string)
    origin_path               = optional(string)
    origin_shield = optional(object({
      enabled              = bool
      origin_shield_region = optional(string)
    }))
    response_completion_timeout = optional(number)
    vpc_origin_config = optional(object({
      origin_keepalive_timeout = optional(number)
      origin_read_timeout      = optional(number)
      vpc_origin_id            = optional(string)
      vpc_origin_key           = optional(string)
      owner_account_id         = optional(string)
    }))
  }))
  default     = {}
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

variable "origin_access_control" {
  description = "Map of CloudFront origin access control"
  type        = map(object({
    description      = optional(string)
    name             = optional(string)
    origin_type      = string
    signing_behavior = string
    signing_protocol = string
  }))
  default     = {
    s3 = {
      origin_type = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }
}

variable "anycast_ip_list_id" {
  description = "ID of the Anycast static IP list that is associated with the distribution"
  type        = string
  default     = null
}

variable "viewer_certificate" {
  description = "The SSL configuration for this distribution"
  type        = object({
    acm_certificate_arn            = optional(string)
    cloudfront_default_certificate = optional(bool)
    iam_certificate_id             = optional(string)
    minimum_protocol_version       = optional(string, "TLSv1.2_2025")
    ssl_support_method             = optional(string)
  })
  default     = {
    cloudfront_default_certificate = true
  }
}

variable "origin_request_policies" {
  description = "Map of CloudFront origin request policies"
  type        = map(object({
    name    = optional(string)
    comment = optional(string)
    cookies_config = object({
      cookie_behavior = string
      cookies = optional(object({
        items = list(string)
      }))
    })
    headers_config = object({
      header_behavior = string
      headers = optional(object({
        items = list(string)
      }))
    })
    query_strings_config = object({
      query_string_behavior = string
      query_strings = optional(object({
        items = list(string)
      }))
    })
  }))
  default     = null
}


output "cloudfront_distribution_hosted_zone_id" {
  description = "The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to."
  value       = module.this.cloudfront_distribution_hosted_zone_id
  sensitive   = true
}

output "connection_function_id" {
  description = "ID of the connection function"
  value       = module.this.connection_function_id
  sensitive   = true
}

output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = module.this.cloudfront_distribution_id
  sensitive   = true
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = module.this.cloudfront_distribution_arn
  sensitive   = true
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.this.cloudfront_distribution_domain_name
  sensitive   = true
}

output "cloudfront_monitoring_subscription_id" {
  description = " The ID of the CloudFront monitoring subscription, which corresponds to the `distribution_id`."
  value       = module.this.cloudfront_monitoring_subscription_id
  sensitive   = true
}

output "connection_function_arn" {
  description = "ARN of the connection function"
  value       = module.this.connection_function_arn
  sensitive   = true
}
