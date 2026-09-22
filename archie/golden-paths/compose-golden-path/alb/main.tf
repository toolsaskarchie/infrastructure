# Governed wrapper around terraform-aws-modules/alb/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.1"

  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  security_group_egress_rules = var.security_group_egress_rules
  desync_mitigation_mode = var.desync_mitigation_mode
  enable_tls_version_and_cipher_suite_headers = var.enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port = var.enable_xff_client_port
  additional_target_group_attachments = var.additional_target_group_attachments
  security_group_name = var.security_group_name
  enable_http2 = var.enable_http2
  timeouts = var.timeouts
  listeners = var.listeners
  route53_records = var.route53_records
  xff_header_processing_mode = var.xff_header_processing_mode
  security_group_ingress_rules = var.security_group_ingress_rules
  minimum_load_balancer_capacity = var.minimum_load_balancer_capacity
  name = var.name
  tags = var.tags
  enable_zonal_shift = var.enable_zonal_shift
  enable_deletion_protection = var.enable_deletion_protection
  enable_waf_fail_open = var.enable_waf_fail_open
  security_groups = var.security_groups
  create_security_group = var.create_security_group
  subnets = var.subnets
  target_groups = var.target_groups
  vpc_id = var.vpc_id
}


variable "enable_cross_zone_load_balancing" {
  description = "If `true`, cross-zone load balancing of the load balancer will be enabled. For application load balancer this feature is always enabled (`true`) and cannot be disabled. Defaults to `true`"
  type        = bool
  default     = true
}

variable "security_group_egress_rules" {
  description = "Security group egress rules to add to the security group created"
  type        = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(string)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(string)
  }))
  default     = null
}

variable "desync_mitigation_mode" {
  description = "Determines how the load balancer handles requests that might pose a security risk to an application due to HTTP desync. Valid values are `monitor`, `defensive` (default), `strictest`"
  type        = string
  default     = null
}

variable "enable_tls_version_and_cipher_suite_headers" {
  description = "Indicates whether the two headers (`x-amzn-tls-version` and `x-amzn-tls-cipher-suite`), which contain information about the negotiated TLS version and cipher suite, are added to the client request bef"
  type        = bool
  default     = null
}

variable "enable_xff_client_port" {
  description = "Indicates whether the X-Forwarded-For header should preserve the source port that the client used to connect to the load balancer in `application` load balancers. Defaults to `false`"
  type        = bool
  default     = null
}

variable "additional_target_group_attachments" {
  description = "Map of additional target group attachments to create. Use `target_group_key` to attach to the target group created in `target_groups`"
  type        = map(object({
    target_group_key  = string
    target_id         = string
    target_type       = optional(string)
    port              = optional(number)
    availability_zone = optional(string)
  }))
  default     = null
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers. Defaults to `true`"
  type        = bool
  default     = null
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the load balancer"
  type        = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
}

variable "listeners" {
  description = "Map of listener configurations to create"
  type        = map(object({
    alpn_policy                 = optional(string)
    certificate_arn             = optional(string)
    additional_certificate_arns = optional(list(string), [])
    authenticate_cognito = optional(object({
      authentication_request_extra_params = optional(map(string))
      on_unauthenticated_request          = optional(string)
      scope                               = optional(string)
      session_cookie_name                 = optional(string)
      session_timeout                     = optional(number)
      user_pool_arn                       = optional(string)
      user_pool_client_id                 = optional(string)
      user_pool_domain                    = optional(string)
    }))
    authenticate_oidc = optional(object({
      authentication_request_extra_params = optional(map(string))
      authorization_endpoint              = string
      client_id                           = string
      client_secret                       = string
      issuer                              = string
      on_unauthenticated_request          = optional(string)
      scope                               = optional(string)
      session_cookie_name                 = optional(string)
      session_timeout                     = optional(number)
      token_endpoint                      = string
      user_info_endpoint                  = string
    }))
    fixed_response = optional(object({
      content_type = string
      message_body = optional(string)
      status_code  = optional(string)
    }))
    forward = optional(object({
      target_group_arn = optional(string)
      target_group_key = optional(string)
    }))
    jwt_validation = optional(object({
      issuer        = string
      jwks_endpoint = string
      additional_claim = optional(list(object({
        format = string
        name   = string
        values = list(string)
      })))
    }))
    weighted_forward = optional(object({
      target_groups = optional(list(object({
        target_group_arn = optional(string)
        target_group_key = optional(string)
        weight           = optional(number)
      })))
      stickiness = optional(object({
        duration = optional(number)
        enabled  = optional(bool)
      }))
    }))
    redirect = optional(object({
      host        = optional(string)
      path        = optional(string)
      port        = optional(string)
      protocol    = optional(string)
      query       = optional(string)
      status_code = string
    }))
    mutual_authentication = optional(object({
      advertise_trust_store_ca_names   = optional(string)
      ignore_client_certificate_expiry = optional(bool)
      mode                             = string
      trust_store_arn                  = optional(string)
    }))
    order                                                                 = optional(number)
    port                                                                  = optional(number)
    protocol                                                              = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_header_name               = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_issuer_header_name        = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_leaf_header_name          = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_subject_header_name       = optional(string)
    routing_http_request_x_amzn_mtls_clientcert_validity_header_name      = optional(string)
    routing_http_request_x_amzn_tls_cipher_suite_header_name              = optional(string)
    routing_http_request_x_amzn_tls_version_header_name                   = optional(string)
    routing_http_response_access_control_allow_credentials_header_value   = optional(string)
    routing_http_response_access_control_allow_headers_header_value       = optional(string)
    routing_http_response_access_control_allow_methods_header_value       = optional(string)
    routing_http_response_access_control_allow_origin_header_value        = optional(string)
    routing_http_response_access_control_expose_headers_header_value      = optional(string)
    routing_http_response_access_control_max_age_header_value             = optional(string)
    routing_http_response_content_security_policy_header_value            = optional(string)
    routing_http_response_server_enabled                                  = optional(bool)
    routing_http_response_strict_transport_security_header_value          = optional(string)
    routing_http_response_x_content_type_options_header_value             = optional(string)
    routing_http_response_x_frame_options_header_value                    = optional(string)
    ssl_policy                                                            = optional(string)
    tcp_idle_timeout_seconds                                              = optional(number)
    tags                                                                  = optional(map(string), {})

    # Listener rules
    rules = optional(map(object({
      actions = list(object({
        authenticate_cognito = optional(object({
          authentication_request_extra_params = optional(map(string))
          on_unauthenticated_request          = optional(string)
          scope                               = optional(string)
          session_cookie_name                 = optional(string)
          session_timeout                     = optional(number)
          user_pool_arn                       = string
          user_pool_client_id                 = string
          user_pool_domain                    = string
        }))
        authenticate_oidc = optional(object({
          authentication_request_extra_params = optional(map(string))
          authorization_endpoint              = string
          client_id                           = string
          client_secret                       = string
          issuer                              = string
          on_unauthenticated_request          = optional(string)
          scope                               = optional(string)
          session_cookie_name                 = optional(string)
          session_timeout                     = optional(number)
          token_endpoint                      = string
          user_info_endpoint                  = string
        }))
        jwt_validation = optional(object({
          issuer        = string
          jwks_endpoint = string
          additional_claim = optional(list(object({
            format = string
            name   = string
            values = list(string)
          })))
        }))
        fixed_response = optional(object({
          content_type = string
          message_body = optional(string)
          status_code  = optional(string)
        }))
        forward = optional(object({
          target_group_arn = optional(string)
          target_group_key = optional(string)
        }))
        order = optional(number)
        redirect = optional(object({
          host        = optional(string)
          path        = optional(string)
          port        = optional(string)
          protocol    = optional(string)
          query       = optional(string)
          status_code = string
        }))
        weighted_forward = optional(object({
          stickiness = optional(object({
            duration = optional(number)
            enabled  = optional(bool)
          }))
          target_groups = optional(list(object({
            target_group_arn = optional(string)
            target_group_key = optional(string)
            weight           = optional(number)
          })))
        }))
      }))
      conditions = list(object({
        host_header = optional(object({
          values       = optional(list(string))
          regex_values = optional(list(string))
        }))
        http_header = optional(object({
          http_header_name = string
          values           = optional(list(string))
          regex_values     = optional(list(string))
        }))
        http_request_method = optional(object({
          values = list(string)
        }))
        path_pattern = optional(object({
          values       = optional(list(string))
          regex_values = optional(list(string))
        }))
        query_string = optional(list(object({
          key   = optional(string)
          value = string
        })))
        source_ip = optional(object({
          values = list(string)
        }))
      }))
      listener_arn = optional(string)
      listener_key = optional(string)
      priority     = optional(number)
      transform = optional(map(object({
        type = optional(string)
        host_header_rewrite_config = optional(object({
          rewrite = optional(object({
            regex   = string
            replace = string
          }))
        }))
        url_rewrite_config = optional(object({
          rewrite = optional(object({
            regex   = string
            replace = string
          }))
        }))
      })))
      tags = optional(map(string), {})
    })), {})
  }))
  default     = {}
}

variable "route53_records" {
  description = "Map of Route53 records to create. Each record map should contain `zone_id`, `name`, and `type`"
  type        = map(object({
    zone_id                = string
    name                   = optional(string)
    type                   = string
    evaluate_target_health = optional(bool, true)
  }))
  default     = null
}

variable "xff_header_processing_mode" {
  description = "Determines how the load balancer modifies the X-Forwarded-For header in the HTTP request before sending the request to the target. The possible values are `append`, `preserve`, and `remove`. Only vali"
  type        = string
  default     = null
}

variable "security_group_ingress_rules" {
  description = "Security group ingress rules to add to the security group created"
  type        = map(object({
    name = optional(string)

    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    description                  = optional(string)
    from_port                    = optional(string)
    ip_protocol                  = optional(string, "tcp")
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    tags                         = optional(map(string), {})
    to_port                      = optional(string)
  }))
  default     = null
}

variable "minimum_load_balancer_capacity" {
  description = "Minimum capacity for a load balancer. Only valid for Load Balancers of type `application` or `network`"
  type        = object({
    capacity_units = number
  })
  default     = null
}

variable "name" {
  description = "The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "enable_zonal_shift" {
  description = "Whether zonal shift is enabled"
  type        = bool
  default     = null
}

variable "enable_deletion_protection" {
  description = "If `true`, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to `true`"
  type        = bool
  default     = true
}

variable "enable_waf_fail_open" {
  description = "Indicates whether to allow a WAF-enabled load balancer to route requests to targets if it is unable to forward the request to AWS WAF. Defaults to `false`"
  type        = bool
  default     = null
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the LB"
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type `network`. Changing this value for load balancers of type `network` will force a recreation of the resour"
  type        = list(string)
  default     = null
}

variable "target_groups" {
  description = "Map of target group configurations to create"
  type        = map(object({
    connection_termination = optional(bool)
    deregistration_delay   = optional(number)
    health_check = optional(object({
      enabled             = optional(bool)
      healthy_threshold   = optional(number)
      interval            = optional(number)
      matcher             = optional(string)
      path                = optional(string)
      port                = optional(string)
      protocol            = optional(string)
      timeout             = optional(number)
      unhealthy_threshold = optional(number)
    }))
    ip_address_type                    = optional(string)
    lambda_multi_value_headers_enabled = optional(bool)
    load_balancing_algorithm_type      = optional(string)
    load_balancing_anomaly_mitigation  = optional(string)
    load_balancing_cross_zone_enabled  = optional(string)
    name                               = optional(string)
    name_prefix                        = optional(string)
    port                               = optional(number)
    preserve_client_ip                 = optional(bool)
    protocol                           = optional(string)
    protocol_version                   = optional(string)
    proxy_protocol_v2                  = optional(bool)
    slow_start                         = optional(number)
    stickiness = optional(object({
      cookie_duration = optional(number)
      cookie_name     = optional(string)
      enabled         = optional(bool)
      type            = string
    }))
    tags = optional(map(string))
    target_failover = optional(list(object({
      on_deregistration = string
      on_unhealthy      = string
    })))
    target_group_health = optional(object({
      dns_failover = optional(object({
        minimum_healthy_targets_count      = optional(string)
        minimum_healthy_targets_percentage = optional(string)
      }))
      unhealthy_state_routing = optional(object({
        minimum_healthy_targets_count      = optional(number)
        minimum_healthy_targets_percentage = optional(string)
      }))
    }))
    target_health_state = optional(object({
      enable_unhealthy_connection_termination = bool
      unhealthy_draining_interval             = optional(number)
    }))
    target_type = optional(string)
    target_id   = optional(string)
    vpc_id      = optional(string)
    # Attachment
    create_attachment = optional(bool, true)
    availability_zone = optional(string)
    # Lambda
    attach_lambda_permission  = optional(bool, false)
    lambda_qualifier          = optional(string)
    lambda_statement_id       = optional(string)
    lambda_action             = optional(string)
    lambda_principal          = optional(string)
    lambda_source_account     = optional(string)
    lambda_event_source_token = optional(string)
  }))
  default     = null
}

variable "vpc_id" {
  description = "Identifier of the VPC where the security group will be created"
  type        = string
  default     = null
}


output "security_group_id" {
  description = "ID of the security group"
  value       = module.this.security_group_id
}

output "arn" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.this.arn
}

output "id" {
  description = "The ID and ARN of the load balancer we created"
  value       = module.this.id
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.this.dns_name
}

output "zone_id" {
  description = "The zone_id of the load balancer to assist with creating DNS records"
  value       = module.this.zone_id
}

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.this.security_group_arn
}

output "arn_suffix" {
  description = "ARN suffix of our load balancer - can be used with CloudWatch"
  value       = module.this.arn_suffix
}

output "target_groups" {
  description = "Map of target groups created and their attributes"
  value       = module.this.target_groups
}
