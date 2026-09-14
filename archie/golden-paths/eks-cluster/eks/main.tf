# Governed wrapper around terraform-aws-modules/eks/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.25.0"

  create_auto_mode_iam_resources = var.create_auto_mode_iam_resources
  create_node_iam_role = var.create_node_iam_role
  enable_cluster_creator_admin_permissions = var.enable_cluster_creator_admin_permissions
  encryption_policy_name = var.encryption_policy_name
  fargate_profiles = var.fargate_profiles
  kms_key_service_users = var.kms_key_service_users
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id = var.cloudwatch_log_group_kms_key_id
  enable_irsa = var.enable_irsa
  create_kms_key = var.create_kms_key
  create_security_group = var.create_security_group
  iam_role_name = var.iam_role_name
  enable_auto_mode_custom_tags = var.enable_auto_mode_custom_tags
  service_ipv4_cidr = var.service_ipv4_cidr
  create_primary_security_group_tags = var.create_primary_security_group_tags
  vpc_id = var.vpc_id
  node_iam_role_name = var.node_iam_role_name
  eks_managed_node_groups = var.eks_managed_node_groups
  tags = var.tags
  kubernetes_version = var.kubernetes_version
  endpoint_public_access = var.endpoint_public_access
  control_plane_egress_mode = var.control_plane_egress_mode
  endpoint_private_access = var.endpoint_private_access
  kms_key_administrators = var.kms_key_administrators
  name = var.name
  identity_providers = var.identity_providers
  self_managed_node_groups = var.self_managed_node_groups
  endpoint_public_access_cidrs = var.endpoint_public_access_cidrs
  kms_key_users = var.kms_key_users
  additional_security_group_ids = var.additional_security_group_ids
  enable_kms_key_rotation = var.enable_kms_key_rotation
  kms_key_owners = var.kms_key_owners
  security_group_id = var.security_group_id
  addons = var.addons
  service_ipv6_cidr = var.service_ipv6_cidr
  create_cloudwatch_log_group = var.create_cloudwatch_log_group
  node_security_group_name = var.node_security_group_name
  security_group_name = var.security_group_name
  access_entries = var.access_entries
  deletion_protection = var.deletion_protection
  timeouts = var.timeouts
  create_node_security_group = var.create_node_security_group
  control_plane_subnet_ids = var.control_plane_subnet_ids
  create_cni_ipv6_iam_policy = var.create_cni_ipv6_iam_policy
  node_security_group_id = var.node_security_group_id
  subnet_ids = var.subnet_ids
  create_iam_role = var.create_iam_role
}


variable "create_auto_mode_iam_resources" {
  description = "Determines whether to create/attach IAM resources for EKS Auto Mode. Useful for when using only custom node pools and not built-in EKS Auto Mode node pools"
  type        = bool
  default     = false
}

variable "create_node_iam_role" {
  description = "Determines whether an EKS Auto node IAM role is created"
  type        = bool
  default     = true
}

variable "enable_cluster_creator_admin_permissions" {
  description = "Indicates whether or not to add the cluster creator (the identity used by Terraform) as an administrator via access entry"
  type        = bool
  default     = false
}

variable "encryption_policy_name" {
  description = "Name to use on cluster encryption policy created"
  type        = string
  default     = null
}

variable "fargate_profiles" {
  description = "Map of Fargate Profile definitions to create"
  type        = map(object({
    create = optional(bool)

    # Fargate profile
    name       = optional(string) # Will fall back to map key
    subnet_ids = optional(list(string))
    selectors = optional(list(object({
      labels    = optional(map(string))
      namespace = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
    }))

    # IAM role
    create_iam_role               = optional(bool)
    iam_role_arn                  = optional(string)
    iam_role_name                 = optional(string)
    iam_role_use_name_prefix      = optional(bool)
    iam_role_path                 = optional(string)
    iam_role_description          = optional(string)
    iam_role_permissions_boundary = optional(string)
    iam_role_tags                 = optional(map(string))
    iam_role_attach_cni_policy    = optional(bool)
    iam_role_additional_policies  = optional(map(string))
    create_iam_role_policy        = optional(bool)
    iam_role_policy_statements = optional(list(object({
      sid           = optional(string)
      actions       = optional(list(string))
      not_actions   = optional(list(string))
      effect        = optional(string)
      resources     = optional(list(string))
      not_resources = optional(list(string))
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      condition = optional(list(object({
        test     = string
        values   = list(string)
        variable = string
      })))
    })))
    tags = optional(map(string))
  }))
  default     = null
}

variable "kms_key_service_users" {
  description = "A list of IAM ARNs for [key service users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-service-integration)"
  type        = list(string)
  default     = []
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Default retention - 90 days"
  type        = number
  default     = 90
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/lates"
  type        = string
  default     = null
}

variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "create_kms_key" {
  description = "Controls if a KMS key for cluster encryption should be created"
  type        = bool
  default     = true
}

variable "create_security_group" {
  description = "Determines if a security group is created for the cluster. Note: the EKS service creates a primary security group for the cluster by default"
  type        = bool
  default     = true
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "enable_auto_mode_custom_tags" {
  description = "Determines whether to enable permissions for custom tags resources created by EKS Auto Mode"
  type        = bool
  default     = true
}

variable "service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = null
}

variable "create_primary_security_group_tags" {
  description = "Indicates whether or not to tag the cluster's primary security group. This security group is created by the EKS service, not the module, and therefore tagging is handled after cluster creation"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster security group will be provisioned"
  type        = string
  default     = null
}

variable "node_iam_role_name" {
  description = "Name to use on the EKS Auto node IAM role created"
  type        = string
  default     = null
}

variable "eks_managed_node_groups" {
  description = "Map of EKS managed node group definitions to create"
  type        = map(object({
    create             = optional(bool)
    kubernetes_version = optional(string)

    # EKS Managed Node Group
    name                           = optional(string) # Will fall back to map key
    use_name_prefix                = optional(bool)
    subnet_ids                     = optional(list(string))
    min_size                       = optional(number)
    max_size                       = optional(number)
    desired_size                   = optional(number)
    ami_id                         = optional(string)
    ami_type                       = optional(string)
    ami_release_version            = optional(string)
    use_latest_ami_release_version = optional(bool)
    capacity_type                  = optional(string)
    disk_size                      = optional(number)
    force_update_version           = optional(bool)
    instance_types                 = optional(list(string))
    labels                         = optional(map(string))
    node_repair_config = optional(object({
      enabled                                 = optional(bool)
      max_parallel_nodes_repaired_count       = optional(number)
      max_parallel_nodes_repaired_percentage  = optional(number)
      max_unhealthy_node_threshold_count      = optional(number)
      max_unhealthy_node_threshold_percentage = optional(number)
      node_repair_config_overrides = optional(list(object({
        min_repair_wait_time_mins = number
        node_monitoring_condition = string
        node_unhealthy_reason     = string
        repair_action             = string
      })))
    }))
    remote_access = optional(object({
      ec2_ssh_key               = optional(string)
      source_security_group_ids = optional(list(string))
    }))
    taints = optional(map(object({
      key    = string
      value  = optional(string)
      effect = string
    })))
    update_config = optional(object({
      max_unavailable            = optional(number)
      max_unavailable_percentage = optional(number)
      update_strategy            = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    # User data
    enable_bootstrap_user_data = optional(bool)
    pre_bootstrap_user_data    = optional(string)
    post_bootstrap_user_data   = optional(string)
    bootstrap_extra_args       = optional(string)
    user_data_template_path    = optional(string)
    cloudinit_pre_nodeadm = optional(list(object({
      content      = string
      content_type = optional(string)
      filename     = optional(string)
      merge_type   = optional(string)
    })))
    cloudinit_post_nodeadm = optional(list(object({
      content      = string
      content_type = optional(string)
      filename     = optional(string)
      merge_type   = optional(string)
    })))
    # Launch Template
    create_launch_template                 = optional(bool)
    use_custom_launch_template             = optional(bool)
    launch_template_id                     = optional(string)
    launch_template_name                   = optional(string) # Will fall back to map key
    launch_template_use_name_prefix        = optional(bool)
    launch_template_version                = optional(string)
    launch_template_default_version        = optional(string)
    update_launch_template_default_version = optional(bool)
    launch_template_description            = optional(string)
    launch_template_tags                   = optional(map(string))
    tag_specifications                     = optional(list(string))
    ebs_optimized                          = optional(bool)
    key_name                               = optional(string)
    disable_api_termination                = optional(bool)
    kernel_id                              = optional(string)
    ram_disk_id                            = optional(string)
    block_device_mappings = optional(map(object({
      device_name = optional(string)
      ebs = optional(object({
        delete_on_termination      = optional(bool)
        encrypted                  = optional(bool)
        iops                       = optional(number)
        kms_key_id                 = optional(string)
        snapshot_id                = optional(string)
        throughput                 = optional(number)
        volume_initialization_rate = optional(number)
        volume_size                = optional(number)
        volume_type                = optional(string)
      }))
      no_device    = optional(string)
      virtual_name = optional(string)
    })))
    capacity_reservation_specification = optional(object({
      capacity_reservation_preference = optional(string)
      capacity_reservation_target = optional(object({
        capacity_reservation_id                 = optional(string)
        capacity_reservation_resource_group_arn = optional(string)
      }))
    }))
    cpu_options = optional(object({
      amd_sev_snp           = optional(string)
      core_count            = optional(number)
      nested_virtualization = optional(string)
      threads_per_core      = optional(number)
    }))
    credit_specification = optional(object({
      cpu_credits = optional(string)
    }))
    enclave_options = optional(object({
      enabled = optional(bool)
    }))
    instance_market_options = optional(object({
      market_type = optional(string)
      spot_options = optional(object({
        block_duration_minutes         = optional(number)
        instance_interruption_behavior = optional(string)
        max_price                      = optional(string)
        spot_instance_type             = optional(string)
        valid_until                    = optional(string)
      }))
    }))
    license_specifications = optional(list(object({
      license_configuration_arn = string
    })))
    metadata_options = optional(object({
      http_endpoint               = optional(string)
      http_protocol_ipv6          = optional(string)
      http_put_response_hop_limit = optional(number)
      http_tokens                 = optional(string)
      instance_metadata_tags      = optional(string)
    }))
    enable_monitoring      = optional(bool)
    enable_efa_support     = optional(bool)
    enable_efa_only        = optional(bool)
    efa_indices            = optional(list(string))
    create_placement_group = optional(bool)
    placement = optional(object({
      affinity                = optional(string)
      availability_zone       = optional(string)
      group_name              = optional(string)
      host_id                 = optional(string)
      host_resource_group_arn = optional(string)
      partition_number        = optional(number)
      spread_domain           = optional(string)
      tenancy                 = optional(string)
    }))
    network_interfaces = optional(list(object({
      associate_carrier_ip_address = optional(bool)
      associate_public_ip_address  = optional(bool)
      connection_tracking_specification = optional(object({
        tcp_established_timeout = optional(number)
        udp_stream_timeout      = optional(number)
        udp_timeout             = optional(number)
      }))
      delete_on_termination = optional(bool)
      description           = optional(string)
      device_index          = optional(number)
      ena_srd_specification = optional(object({
        ena_srd_enabled = optional(bool)
        ena_srd_udp_specification = optional(object({
          ena_srd_udp_enabled = optional(bool)
        }))
      }))
      interface_type       = optional(string)
      ipv4_address_count   = optional(number)
      ipv4_addresses       = optional(list(string))
      ipv4_prefix_count    = optional(number)
      ipv4_prefixes        = optional(list(string))
      ipv6_address_count   = optional(number)
      ipv6_addresses       = optional(list(string))
      ipv6_prefix_count    = optional(number)
      ipv6_prefixes        = optional(list(string))
      network_card_index   = optional(number)
      network_interface_id = optional(string)
      primary_ipv6         = optional(bool)
      private_ip_address   = optional(string)
      security_groups      = optional(list(string), [])
      subnet_id            = optional(string)
    })))
    network_performance_options = optional(object({
      bandwidth_weighting = optional(string)
    }))
    maintenance_options = optional(object({
      auto_recovery = optional(string)
    }))
    private_dns_name_options = optional(object({
      enable_resource_name_dns_aaaa_record = optional(bool)
      enable_resource_name_dns_a_record    = optional(bool)
      hostname_type                        = optional(string)
    }))
    # IAM role
    create_iam_role               = optional(bool)
    iam_role_arn                  = optional(string)
    iam_role_name                 = optional(string)
    iam_role_use_name_prefix      = optional(bool)
    iam_role_path                 = optional(string)
    iam_role_description          = optional(string)
    iam_role_permissions_boundary = optional(string)
    iam_role_tags                 = optional(map(string))
    iam_role_attach_cni_policy    = optional(bool)
    iam_role_additional_policies  = optional(map(string))
    create_iam_role_policy        = optional(bool)
    iam_role_policy_statements = optional(list(object({
      sid           = optional(string)
      actions       = optional(list(string))
      not_actions   = optional(list(string))
      effect        = optional(string)
      resources     = optional(list(string))
      not_resources = optional(list(string))
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      condition = optional(list(object({
        test     = string
        values   = list(string)
        variable = string
      })))
    })))
    # Security group
    vpc_security_group_ids                = optional(list(string), [])
    attach_cluster_primary_security_group = optional(bool, false)
    cluster_primary_security_group_id     = optional(string)
    create_security_group                 = optional(bool)
    security_group_name                   = optional(string)
    security_group_use_name_prefix        = optional(bool)
    security_group_description            = optional(string)
    security_group_ingress_rules = optional(map(object({
      name                         = optional(string)
      cidr_ipv4                    = optional(string)
      cidr_ipv6                    = optional(string)
      description                  = optional(string)
      from_port                    = optional(string)
      ip_protocol                  = optional(string)
      prefix_list_id               = optional(string)
      referenced_security_group_id = optional(string)
      self                         = optional(bool)
      tags                         = optional(map(string))
      to_port                      = optional(string)
    })))
    security_group_egress_rules = optional(map(object({
      name                         = optional(string)
      cidr_ipv4                    = optional(string)
      cidr_ipv6                    = optional(string)
      description                  = optional(string)
      from_port                    = optional(string)
      ip_protocol                  = optional(string)
      prefix_list_id               = optional(string)
      referenced_security_group_id = optional(string)
      self                         = optional(bool)
      tags                         = optional(map(string))
      to_port                      = optional(string)
    })), {})
    security_group_tags = optional(map(string))

    tags = optional(map(string))
  }))
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "kubernetes_version" {
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster (i.e.: `1.33`)"
  type        = string
  default     = null
}

variable "endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "control_plane_egress_mode" {
  description = "Egress mode for the EKS control plane. Valid values are `AWS_MANAGED` and `CUSTOMER_ROUTED`"
  type        = string
  default     = null
}

variable "endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "kms_key_administrators" {
  description = "A list of IAM ARNs for [key administrators](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-administrators). If no value is provided, the current"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = ""
}

variable "identity_providers" {
  description = "Map of cluster identity provider configurations to enable for the cluster. Note - this is different/separate from IRSA"
  type        = map(object({
    client_id                     = string
    groups_claim                  = optional(string)
    groups_prefix                 = optional(string)
    identity_provider_config_name = optional(string) # will fall back to map key
    issuer_url                    = string
    required_claims               = optional(map(string))
    username_claim                = optional(string)
    username_prefix               = optional(string)
    tags                          = optional(map(string), {})
  }))
  default     = null
}

variable "self_managed_node_groups" {
  description = "Map of self-managed node group definitions to create"
  type        = map(object({
    create             = optional(bool)
    kubernetes_version = optional(string)

    # Autoscaling Group
    create_autoscaling_group         = optional(bool)
    name                             = optional(string) # Will fall back to map key
    use_name_prefix                  = optional(bool)
    availability_zones               = optional(list(string))
    subnet_ids                       = optional(list(string))
    min_size                         = optional(number)
    max_size                         = optional(number)
    desired_size                     = optional(number)
    desired_size_type                = optional(string)
    capacity_rebalance               = optional(bool)
    default_instance_warmup          = optional(number)
    protect_from_scale_in            = optional(bool)
    context                          = optional(string)
    create_placement_group           = optional(bool)
    placement_group                  = optional(string)
    health_check_type                = optional(string)
    health_check_grace_period        = optional(number)
    ignore_failed_scaling_activities = optional(bool)
    force_delete                     = optional(bool)
    termination_policies             = optional(list(string))
    suspended_processes              = optional(list(string))
    max_instance_lifetime            = optional(number)
    enabled_metrics                  = optional(list(string))
    metrics_granularity              = optional(string)
    initial_lifecycle_hooks = optional(list(object({
      default_result          = optional(string)
      heartbeat_timeout       = optional(number)
      lifecycle_transition    = string
      name                    = string
      notification_metadata   = optional(string)
      notification_target_arn = optional(string)
      role_arn                = optional(string)
    })))
    instance_maintenance_policy = optional(object({
      max_healthy_percentage = number
      min_healthy_percentage = number
    }))
    instance_refresh = optional(object({
      preferences = optional(object({
        alarm_specification = optional(object({
          alarms = optional(list(string))
        }))
        auto_rollback                = optional(bool)
        checkpoint_delay             = optional(number)
        checkpoint_percentages       = optional(list(number))
        instance_warmup              = optional(number)
        max_healthy_percentage       = optional(number)
        min_healthy_percentage       = optional(number)
        scale_in_protected_instances = optional(string)
        skip_matching                = optional(bool)
        standby_instances            = optional(string)
      }))
      strategy = optional(string)
      triggers = optional(list(string))
      })
    )
    use_mixed_instances_policy = optional(bool)
    mixed_instances_policy = optional(object({
      instances_distribution = optional(object({
        on_demand_allocation_strategy            = optional(string)
        on_demand_base_capacity                  = optional(number)
        on_demand_percentage_above_base_capacity = optional(number)
        spot_allocation_strategy                 = optional(string)
        spot_instance_pools                      = optional(number)
        spot_max_price                           = optional(string)
      }))
      launch_template = object({
        override = optional(list(object({
          instance_requirements = optional(object({
            accelerator_count = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            accelerator_manufacturers = optional(list(string))
            accelerator_names         = optional(list(string))
            accelerator_total_memory_mib = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            accelerator_types      = optional(list(string))
            allowed_instance_types = optional(list(string))
            bare_metal             = optional(string)
            baseline_ebs_bandwidth_mbps = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            burstable_performance                                   = optional(string)
            cpu_manufacturers                                       = optional(list(string))
            excluded_instance_types                                 = optional(list(string))
            instance_generations                                    = optional(list(string))
            local_storage                                           = optional(string)
            local_storage_types                                     = optional(list(string))
            max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)
            memory_gib_per_vcpu = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            memory_mib = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            network_bandwidth_gbps = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            network_interface_count = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            on_demand_max_price_percentage_over_lowest_price = optional(number)
            require_hibernate_support                        = optional(bool)
            spot_max_price_percentage_over_lowest_price      = optional(number)
            total_local_storage_gb = optional(object({
              max = optional(number)
              min = optional(number)
            }))
            vcpu_count = optional(object({
              max = optional(number)
              min = optional(number)
            }))
          }))
          instance_type = optional(string)
          launch_template_specification = optional(object({
            launch_template_id   = optional(string)
            launch_template_name = optional(string)
            version              = optional(string)
          }))
          weighted_capacity = optional(string)
        })))
      })
    }))
    timeouts = optional(object({
      delete = optional(string)
    }))
    autoscaling_group_tags = optional(map(string))
    # User data
    ami_type                   = optional(string)
    additional_cluster_dns_ips = optional(list(string))
    pre_bootstrap_user_data    = optional(string)
    post_bootstrap_user_data   = optional(string)
    bootstrap_extra_args       = optional(string)
    user_data_template_path    = optional(string)
    cloudinit_pre_nodeadm = optional(list(object({
      content      = string
      content_type = optional(string)
      filename     = optional(string)
      merge_type   = optional(string)
    })))
    cloudinit_post_nodeadm = optional(list(object({
      content      = string
      content_type = optional(string)
      filename     = optional(string)
      merge_type   = optional(string)
    })))
    # Launch Template
    create_launch_template                 = optional(bool)
    use_custom_launch_template             = optional(bool)
    launch_template_id                     = optional(string)
    launch_template_name                   = optional(string) # Will fall back to map key
    launch_template_use_name_prefix        = optional(bool)
    launch_template_version                = optional(string)
    launch_template_default_version        = optional(string)
    update_launch_template_default_version = optional(bool)
    launch_template_description            = optional(string)
    launch_template_tags                   = optional(map(string))
    tag_specifications                     = optional(list(string))
    ebs_optimized                          = optional(bool)
    ami_id                                 = optional(string)
    instance_type                          = optional(string)
    key_name                               = optional(string)
    disable_api_termination                = optional(bool)
    instance_initiated_shutdown_behavior   = optional(string)
    kernel_id                              = optional(string)
    ram_disk_id                            = optional(string)
    block_device_mappings = optional(map(object({
      device_name = optional(string)
      ebs = optional(object({
        delete_on_termination      = optional(bool)
        encrypted                  = optional(bool)
        iops                       = optional(number)
        kms_key_id                 = optional(string)
        snapshot_id                = optional(string)
        throughput                 = optional(number)
        volume_initialization_rate = optional(number)
        volume_size                = optional(number)
        volume_type                = optional(string)
      }))
      no_device    = optional(string)
      virtual_name = optional(string)
    })))
    capacity_reservation_specification = optional(object({
      capacity_reservation_preference = optional(string)
      capacity_reservation_target = optional(object({
        capacity_reservation_id                 = optional(string)
        capacity_reservation_resource_group_arn = optional(string)
      }))
    }))
    cpu_options = optional(object({
      amd_sev_snp           = optional(string)
      core_count            = optional(number)
      nested_virtualization = optional(string)
      threads_per_core      = optional(number)
    }))
    credit_specification = optional(object({
      cpu_credits = optional(string)
    }))
    enclave_options = optional(object({
      enabled = optional(bool)
    }))
    instance_requirements = optional(object({
      accelerator_count = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      accelerator_manufacturers = optional(list(string))
      accelerator_names         = optional(list(string))
      accelerator_total_memory_mib = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      accelerator_types      = optional(list(string))
      allowed_instance_types = optional(list(string))
      bare_metal             = optional(string)
      baseline_ebs_bandwidth_mbps = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      burstable_performance                                   = optional(string)
      cpu_manufacturers                                       = optional(list(string))
      excluded_instance_types                                 = optional(list(string))
      instance_generations                                    = optional(list(string))
      local_storage                                           = optional(string)
      local_storage_types                                     = optional(list(string))
      max_spot_price_as_percentage_of_optimal_on_demand_price = optional(number)
      memory_gib_per_vcpu = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      memory_mib = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      network_bandwidth_gbps = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      network_interface_count = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      on_demand_max_price_percentage_over_lowest_price = optional(number)
      require_hibernate_support                        = optional(bool)
      spot_max_price_percentage_over_lowest_price      = optional(number)
      total_local_storage_gb = optional(object({
        max = optional(number)
        min = optional(number)
      }))
      vcpu_count = optional(object({
        max = optional(number)
        min = string
      }))
    }))
    instance_market_options = optional(object({
      market_type = optional(string)
      spot_options = optional(object({
        block_duration_minutes         = optional(number)
        instance_interruption_behavior = optional(string)
        max_price                      = optional(string)
        spot_instance_type             = optional(string)
        valid_until                    = optional(string)
      }))
    }))
    license_specifications = optional(list(object({
      license_configuration_arn = string
    })))
    metadata_options = optional(object({
      http_endpoint               = optional(string)
      http_protocol_ipv6          = optional(string)
      http_put_response_hop_limit = optional(number)
      http_tokens                 = optional(string)
      instance_metadata_tags      = optional(string)
    }))
    enable_monitoring  = optional(bool)
    enable_efa_support = optional(bool)
    enable_efa_only    = optional(bool)
    efa_indices        = optional(list(string))
    network_interfaces = optional(list(object({
      associate_carrier_ip_address = optional(bool)
      associate_public_ip_address  = optional(bool)
      connection_tracking_specification = optional(object({
        tcp_established_timeout = optional(number)
        udp_stream_timeout      = optional(number)
        udp_timeout             = optional(number)
      }))
      delete_on_termination = optional(bool)
      description           = optional(string)
      device_index          = optional(number)
      ena_srd_specification = optional(object({
        ena_srd_enabled = optional(bool)
        ena_srd_udp_specification = optional(object({
          ena_srd_udp_enabled = optional(bool)
        }))
      }))
      interface_type       = optional(string)
      ipv4_address_count   = optional(number)
      ipv4_addresses       = optional(list(string))
      ipv4_prefix_count    = optional(number)
      ipv4_prefixes        = optional(list(string))
      ipv6_address_count   = optional(number)
      ipv6_addresses       = optional(list(string))
      ipv6_prefix_count    = optional(number)
      ipv6_prefixes        = optional(list(string))
      network_card_index   = optional(number)
      network_interface_id = optional(string)
      primary_ipv6         = optional(bool)
      private_ip_address   = optional(string)
      security_groups      = optional(list(string))
      subnet_id            = optional(string)
    })))
    network_performance_options = optional(object({
      bandwidth_weighting = optional(string)
    }))
    placement = optional(object({
      affinity                = optional(string)
      availability_zone       = optional(string)
      group_name              = optional(string)
      host_id                 = optional(string)
      host_resource_group_arn = optional(string)
      partition_number        = optional(number)
      spread_domain           = optional(string)
      tenancy                 = optional(string)
    }))
    maintenance_options = optional(object({
      auto_recovery = optional(string)
    }))
    private_dns_name_options = optional(object({
      enable_resource_name_dns_aaaa_record = optional(bool)
      enable_resource_name_dns_a_record    = optional(bool)
      hostname_type                        = optional(string)
    }))
    # IAM role
    create_iam_instance_profile   = optional(bool)
    iam_instance_profile_arn      = optional(string)
    iam_role_name                 = optional(string)
    iam_role_use_name_prefix      = optional(bool)
    iam_role_path                 = optional(string)
    iam_role_description          = optional(string)
    iam_role_permissions_boundary = optional(string)
    iam_role_tags                 = optional(map(string))
    iam_role_attach_cni_policy    = optional(bool)
    iam_role_additional_policies  = optional(map(string))
    create_iam_role_policy        = optional(bool)
    iam_role_policy_statements = optional(list(object({
      sid           = optional(string)
      actions       = optional(list(string))
      not_actions   = optional(list(string))
      effect        = optional(string)
      resources     = optional(list(string))
      not_resources = optional(list(string))
      principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      not_principals = optional(list(object({
        type        = string
        identifiers = list(string)
      })))
      condition = optional(list(object({
        test     = string
        values   = list(string)
        variable = string
      })))
    })))
    # Access entry
    create_access_entry = optional(bool)
    iam_role_arn        = optional(string)
    # Security group
    vpc_security_group_ids                = optional(list(string), [])
    attach_cluster_primary_security_group = optional(bool, false)
    create_security_group                 = optional(bool)
    security_group_name                   = optional(string)
    security_group_use_name_prefix        = optional(bool)
    security_group_description            = optional(string)
    security_group_ingress_rules = optional(map(object({
      name                         = optional(string)
      cidr_ipv4                    = optional(string)
      cidr_ipv6                    = optional(string)
      description                  = optional(string)
      from_port                    = optional(string)
      ip_protocol                  = optional(string)
      prefix_list_id               = optional(string)
      referenced_security_group_id = optional(string)
      self                         = optional(bool)
      tags                         = optional(map(string))
      to_port                      = optional(string)
    })))
    security_group_egress_rules = optional(map(object({
      name                         = optional(string)
      cidr_ipv4                    = optional(string)
      cidr_ipv6                    = optional(string)
      description                  = optional(string)
      from_port                    = optional(string)
      ip_protocol                  = optional(string)
      prefix_list_id               = optional(string)
      referenced_security_group_id = optional(string)
      self                         = optional(bool)
      tags                         = optional(map(string))
      to_port                      = optional(string)
    })))
    security_group_tags = optional(map(string))

    tags = optional(map(string))
  }))
  default     = null
}

variable "endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "kms_key_users" {
  description = "A list of IAM ARNs for [key users](https://docs.aws.amazon.com/kms/latest/developerguide/key-policy-default.html#key-policy-default-allow-users)"
  type        = list(string)
  default     = []
}

variable "additional_security_group_ids" {
  description = "List of additional, externally created security group IDs to attach to the cluster control plane"
  type        = list(string)
  default     = []
}

variable "enable_kms_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true
}

variable "kms_key_owners" {
  description = "A list of IAM ARNs for those who will have full key permissions (`kms:*`)"
  type        = list(string)
  default     = []
}

variable "security_group_id" {
  description = "Existing security group ID to be attached to the cluster"
  type        = string
  default     = ""
}

variable "addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = map(object({
    name                 = optional(string) # will fall back to map key
    before_compute       = optional(bool, false)
    most_recent          = optional(bool, true)
    addon_version        = optional(string)
    configuration_values = optional(string)
    namespace_config = optional(object({
      namespace = string
    }))
    pod_identity_association = optional(list(object({
      role_arn        = string
      service_account = string
    })))
    preserve                    = optional(bool, true)
    resolve_conflicts_on_create = optional(string, "NONE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
    timeouts = optional(object({
      create = optional(string)
      update = optional(string)
      delete = optional(string)
    }), {})
    tags = optional(map(string), {})
  }))
  default     = null
}

variable "service_ipv6_cidr" {
  description = "The CIDR block to assign Kubernetes pod and service IP addresses from if `ipv6` was specified when the cluster was created. Kubernetes assigns service addresses from the unique local address range (fc"
  type        = string
  default     = null
}

variable "create_cloudwatch_log_group" {
  description = "Determines whether a log group is created by this module for the cluster logs. If not, AWS will automatically create one if logging is enabled"
  type        = bool
  default     = true
}

variable "node_security_group_name" {
  description = "Name to use on node security group created"
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name to use on cluster security group created"
  type        = string
  default     = null
}

variable "access_entries" {
  description = "Map of access entries to add to the cluster"
  type        = map(object({
    # Access entry
    kubernetes_groups = optional(list(string))
    principal_arn     = string
    type              = optional(string, "STANDARD")
    user_name         = optional(string)
    tags              = optional(map(string), {})
    # Access policy association
    policy_associations = optional(map(object({
      policy_arn = string
      access_scope = object({
        namespaces = optional(list(string))
        type       = string
      })
    })), {})
  }))
  default     = {}
}

variable "deletion_protection" {
  description = "Whether to enable deletion protection for the cluster. When enabled, the cluster cannot be deleted unless deletion protection is first disabled"
  type        = bool
  default     = null
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the cluster"
  type        = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
}

variable "create_node_security_group" {
  description = "Determines whether to create a security group for the node groups or use the existing `node_security_group_id`"
  type        = bool
  default     = true
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. Used for expanding the pool of subnets used by nodes/node groups without replacing the EKS control plane"
  type        = list(string)
  default     = []
}

variable "create_cni_ipv6_iam_policy" {
  description = "Determines whether to create an [`AmazonEKS_CNI_IPv6_Policy`](https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html#cni-iam-role-create-ipv6-policy)"
  type        = bool
  default     = false
}

variable "node_security_group_id" {
  description = "ID of an existing security group to attach to the node groups created"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
  type        = list(string)
  default     = []
}

variable "create_iam_role" {
  description = "Determines whether an IAM role is created for the cluster"
  type        = bool
  default     = true
}


output "cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.this.cluster_name
}

output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.this.kms_key_id
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = module.this.cluster_endpoint
}

output "kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.this.kms_key_arn
}

output "cluster_primary_security_group_id" {
  description = "Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication"
  value       = module.this.cluster_primary_security_group_id
}

output "cluster_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the cluster security group"
  value       = module.this.cluster_security_group_arn
}

output "node_security_group_id" {
  description = "ID of the node shared security group"
  value       = module.this.node_security_group_id
}

output "node_security_group_arn" {
  description = "Amazon Resource Name (ARN) of the node shared security group"
  value       = module.this.node_security_group_arn
}

output "cluster_iam_role_name" {
  description = "Cluster IAM role name"
  value       = module.this.cluster_iam_role_name
}

output "node_iam_role_name" {
  description = "EKS Auto node IAM role name"
  value       = module.this.node_iam_role_name
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.this.cluster_arn
}

output "cluster_id" {
  description = "The ID of the EKS cluster. Note: currently a value is returned only for local EKS clusters created on Outposts"
  value       = module.this.cluster_id
}

output "cluster_security_group_id" {
  description = "ID of the cluster security group"
  value       = module.this.cluster_security_group_id
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider if `enable_irsa = true`"
  value       = module.this.oidc_provider_arn
}

output "node_iam_role_arn" {
  description = "EKS Auto node IAM role ARN"
  value       = module.this.node_iam_role_arn
}

output "cluster_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.this.cluster_iam_role_unique_id
}

output "node_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.this.node_iam_role_unique_id
}

output "cluster_iam_role_arn" {
  description = "Cluster IAM role ARN"
  value       = module.this.cluster_iam_role_arn
}

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.this.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.this.cloudwatch_log_group_arn
}

output "cluster_dualstack_oidc_issuer_url" {
  description = "Dual-stack compatible URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.this.cluster_dualstack_oidc_issuer_url
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.this.cluster_oidc_issuer_url
}

output "cluster_service_cidr" {
  description = "The CIDR block where Kubernetes pod and service IP addresses are assigned from"
  value       = module.this.cluster_service_cidr
}

output "eks_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by EKS managed node groups"
  value       = module.this.eks_managed_node_groups_autoscaling_group_names
}

output "self_managed_node_groups" {
  description = "Map of attribute maps for all self managed node groups created"
  value       = module.this.self_managed_node_groups
}

output "eks_managed_node_groups" {
  description = "Map of attribute maps for all EKS managed node groups created"
  value       = module.this.eks_managed_node_groups
}

output "self_managed_node_groups_autoscaling_group_names" {
  description = "List of the autoscaling group names created by self-managed node groups"
  value       = module.this.self_managed_node_groups_autoscaling_group_names
}
