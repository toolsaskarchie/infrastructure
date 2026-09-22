# Governed wrapper around terraform-aws-modules/ecs/aws//modules/service.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "7.6.1"

  tags = var.tags
  container_definitions = var.container_definitions
  autoscaling_max_capacity = var.autoscaling_max_capacity
  security_group_egress_rules = var.security_group_egress_rules
  create_infrastructure_iam_role = var.create_infrastructure_iam_role
  pid_mode = var.pid_mode
  security_group_name = var.security_group_name
  security_group_ids = var.security_group_ids
  iam_role_name = var.iam_role_name
  desired_count = var.desired_count
  external_id = var.external_id
  infrastructure_iam_role_name = var.infrastructure_iam_role_name
  autoscaling_min_capacity = var.autoscaling_min_capacity
  create_security_group = var.create_security_group
  create_iam_role = var.create_iam_role
  ipc_mode = var.ipc_mode
  task_exec_iam_role_name = var.task_exec_iam_role_name
  enable_execute_command = var.enable_execute_command
  create_task_exec_policy = var.create_task_exec_policy
  tasks_iam_role_name = var.tasks_iam_role_name
  create_task_exec_iam_role = var.create_task_exec_iam_role
  autoscaling_policies = var.autoscaling_policies
  task_exec_iam_role_policies = var.task_exec_iam_role_policies
  security_group_ingress_rules = var.security_group_ingress_rules
  name = var.name
  create_tasks_iam_role = var.create_tasks_iam_role
  enable_autoscaling = var.enable_autoscaling
  autoscaling_scheduled_actions = var.autoscaling_scheduled_actions
  vpc_id = var.vpc_id
  create_task_definition = var.create_task_definition
  enable_fault_injection = var.enable_fault_injection
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  tasks_iam_role_policies = var.tasks_iam_role_policies
  create_service = var.create_service
  subnet_ids = var.subnet_ids
  timeouts = var.timeouts
  family = var.family
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "container_definitions" {
  description = "A map of valid [container definitions](http://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html). Please note that you should only provide values that are part of the cont"
  type        = map(object({
    create                  = optional(bool, true)
    operating_system_family = optional(string)
    tags                    = optional(map(string))

    # Container definition
    command         = optional(list(string))
    cpu             = optional(number)
    credentialSpecs = optional(list(string))
    dependsOn = optional(list(object({
      condition     = string
      containerName = string
    })))
    disableNetworking     = optional(bool)
    dnsSearchDomains      = optional(list(string))
    dnsServers            = optional(list(string))
    dockerLabels          = optional(map(string))
    dockerSecurityOptions = optional(list(string))
    # enable_execute_command = optional(bool, false) Set in standalone variable
    entrypoint = optional(list(string))
    environment = optional(list(object({
      name  = string
      value = string
    })))
    environmentFiles = optional(list(object({
      type  = string
      value = string
    })))
    essential = optional(bool)
    extraHosts = optional(list(object({
      hostname  = string
      ipAddress = string
    })))
    firelensConfiguration = optional(object({
      options = optional(map(string))
      type    = optional(string)
    }))
    healthCheck = optional(object({
      command     = optional(list(string), [])
      interval    = optional(number, 30)
      retries     = optional(number, 3)
      startPeriod = optional(number)
      timeout     = optional(number, 5)
    }))
    hostname    = optional(string)
    image       = optional(string)
    interactive = optional(bool)
    links       = optional(list(string))
    linuxParameters = optional(object({
      capabilities = optional(object({
        add  = optional(list(string))
        drop = optional(list(string))
      }))
      devices = optional(list(object({
        containerPath = optional(string)
        hostPath      = optional(string)
        permissions   = optional(list(string))
      })))
      initProcessEnabled = optional(bool)
      maxSwap            = optional(number)
      sharedMemorySize   = optional(number)
      swappiness         = optional(number)
      tmpfs = optional(list(object({
        containerPath = string
        mountOptions  = optional(list(string))
        size          = number
      })))
    }))
    logConfiguration = optional(object({
      logDriver = optional(string)
      options   = optional(map(string))
      secretOptions = optional(list(object({
        name      = string
        valueFrom = string
      })))
    }))
    memory            = optional(number)
    memoryReservation = optional(number)
    mountPoints = optional(list(object({
      containerPath = optional(string)
      readOnly      = optional(bool)
      sourceVolume  = optional(string)
    })))
    name = optional(string)
    portMappings = optional(list(object({
      appProtocol        = optional(string)
      containerPort      = optional(number)
      containerPortRange = optional(string)
      hostPort           = optional(number)
      name               = optional(string)
      protocol           = optional(string)
    })))
    privileged             = optional(bool)
    pseudoTerminal         = optional(bool)
    readonlyRootFilesystem = optional(bool)
    repositoryCredentials = optional(object({
      credentialsParameter = optional(string)
    }))
    resourceRequirements = optional(list(object({
      type  = string
      value = string
    })))
    restartPolicy = optional(object({
      enabled              = optional(bool)
      ignoredExitCodes     = optional(list(number))
      restartAttemptPeriod = optional(number)
      })
    )
    secrets = optional(list(object({
      name      = string
      valueFrom = string
    })))
    startTimeout = optional(number, 30)
    stopTimeout  = optional(number, 120)
    systemControls = optional(list(object({
      namespace = optional(string)
      value     = optional(string)
    })))
    ulimits = optional(list(object({
      hardLimit = number
      name      = string
      softLimit = number
    })))
    user               = optional(string)
    versionConsistency = optional(string)
    volumesFrom = optional(list(object({
      readOnly        = optional(bool)
      sourceContainer = optional(string)
    })))
    workingDirectory = optional(string)

    # Cloudwatch Log Group
    service                                = optional(string)
    enable_cloudwatch_logging              = optional(bool)
    create_cloudwatch_log_group            = optional(bool)
    cloudwatch_log_group_name              = optional(string)
    cloudwatch_log_group_use_name_prefix   = optional(bool)
    cloudwatch_log_group_class             = optional(string)
    cloudwatch_log_group_retention_in_days = optional(number)
    cloudwatch_log_group_kms_key_id        = optional(string)
  }))
  default     = {}
}

variable "autoscaling_max_capacity" {
  description = "Maximum number of tasks to run in your service"
  type        = number
  default     = 10
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
  default     = {}
}

variable "create_infrastructure_iam_role" {
  description = "Determines whether the ECS infrastructure IAM role should be created"
  type        = bool
  default     = true
}

variable "pid_mode" {
  description = "Process namespace to use for the containers in the task. The valid values are `host` and `task`"
  type        = string
  default     = null
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security groups to associate with the task or service"
  type        = list(string)
  default     = []
}

variable "iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "desired_count" {
  description = "Number of instances of the task definition to place and keep running"
  type        = number
  default     = 1
}

variable "external_id" {
  description = "The external ID associated with the task set"
  type        = string
  default     = null
}

variable "infrastructure_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "autoscaling_min_capacity" {
  description = "Minimum number of tasks to run in your service"
  type        = number
  default     = 1
}

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "create_iam_role" {
  description = "Determines whether the ECS service IAM role should be created"
  type        = bool
  default     = true
}

variable "ipc_mode" {
  description = "IPC resource namespace to be used for the containers in the task The valid values are `host`, `task`, and `none`"
  type        = string
  default     = null
}

variable "task_exec_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "enable_execute_command" {
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  type        = bool
  default     = false
}

variable "create_task_exec_policy" {
  description = "Determines whether the ECS task definition IAM policy should be created. This includes permissions included in AmazonECSTaskExecutionRolePolicy as well as access to secrets and SSM parameters"
  type        = bool
  default     = true
}

variable "tasks_iam_role_name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "create_task_exec_iam_role" {
  description = "Determines whether the ECS task definition IAM role should be created"
  type        = bool
  default     = true
}

variable "autoscaling_policies" {
  description = "Map of autoscaling policies to create for the service"
  type        = map(object({
    name        = optional(string) # Will fall back to the key name if not provided
    policy_type = optional(string, "TargetTrackingScaling")
    predictive_scaling_policy_configuration = optional(object({
      max_capacity_breach_behavior = optional(string)
      max_capacity_buffer          = optional(number)
      metric_specification = list(object({
        customized_capacity_metric_specification = optional(object({
          metric_data_query = list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimension = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = optional(string)
                namespace   = optional(string)
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          }))
        }))
        customized_load_metric_specification = optional(object({
          metric_data_query = list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimension = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = optional(string)
                namespace   = optional(string)
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          }))
        }))
        customized_scaling_metric_specification = optional(object({
          metric_data_query = list(object({
            expression = optional(string)
            id         = string
            label      = optional(string)
            metric_stat = optional(object({
              metric = object({
                dimension = optional(list(object({
                  name  = string
                  value = string
                })))
                metric_name = optional(string)
                namespace   = optional(string)
              })
              stat = string
              unit = optional(string)
            }))
            return_data = optional(bool)
          }))
        }))
        predefined_load_metric_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        predefined_metric_pair_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        predefined_scaling_metric_specification = optional(object({
          predefined_metric_type = string
          resource_label         = optional(string)
        }))
        target_value = number
      }))
      mode                   = optional(string)
      scheduling_buffer_time = optional(number)
    }))
    step_scaling_policy_configuration = optional(object({
      adjustment_type          = optional(string)
      cooldown                 = optional(number)
      metric_aggregation_type  = optional(string)
      min_adjustment_magnitude = optional(number)
      step_adjustment = optional(list(object({
        metric_interval_lower_bound = optional(string)
        metric_interval_upper_bound = optional(string)
        scaling_adjustment          = number
      })))
    }))
    target_tracking_scaling_policy_configuration = optional(object({
      customized_metric_specification = optional(object({
        dimensions = optional(list(object({
          name  = string
          value = string
        })))
        metric_name = optional(string)
        metrics = optional(list(object({
          expression = optional(string)
          id         = string
          label      = optional(string)
          metric_stat = optional(object({
            metric = object({
              dimensions = optional(list(object({
                name  = string
                value = string
              })))
              metric_name = string
              namespace   = string
            })
            stat = string
            unit = optional(string)
          }))
          return_data = optional(bool)
        })))
        namespace = optional(string)
        statistic = optional(string)
        unit      = optional(string)
      }))
      disable_scale_in = optional(bool)
      predefined_metric_specification = optional(object({
        predefined_metric_type = string
        resource_label         = optional(string)
      }))
      scale_in_cooldown  = optional(number, 300)
      scale_out_cooldown = optional(number, 60)
      target_value       = optional(number, 75)
    }))
  }))
  default     = {
    cpu = {
      policy_type = "TargetTrackingScaling"
      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageCPUUtilization"
        }
      }
    }
    memory = {
      policy_type = "TargetTrackingScaling"
      target_tracking_scaling_policy_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ECSServiceAverageMemoryUtilization"
        }
      }
    }
  }
}

variable "task_exec_iam_role_policies" {
  description = "Map of IAM role policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
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
  default     = {}
}

variable "name" {
  description = "Name of the service (up to 255 letters, numbers, hyphens, and underscores)"
  type        = string
  default     = ""
}

variable "create_tasks_iam_role" {
  description = "Determines whether the ECS tasks IAM role should be created"
  type        = bool
  default     = true
}

variable "enable_autoscaling" {
  description = "Determines whether to enable autoscaling for the service"
  type        = bool
  default     = true
}

variable "autoscaling_scheduled_actions" {
  description = "Map of autoscaling scheduled actions to create for the service"
  type        = map(object({
    name         = optional(string)
    min_capacity = number
    max_capacity = number
    schedule     = string
    start_time   = optional(string)
    end_time     = optional(string)
    timezone     = optional(string)
  }))
  default     = null
}

variable "vpc_id" {
  description = "The VPC ID where to deploy the task or service. If not provided, the VPC ID is derived from the subnets provided"
  type        = string
  default     = null
}

variable "create_task_definition" {
  description = "Determines whether to create a task definition or use existing/provided"
  type        = bool
  default     = true
}

variable "enable_fault_injection" {
  description = "Enables fault injection and allows for fault injection requests to be accepted from the task's containers. Default is `false`"
  type        = bool
  default     = null
}

variable "enable_ecs_managed_tags" {
  description = "Specifies whether to enable Amazon ECS managed tags for the tasks within the service"
  type        = bool
  default     = true
}

variable "tasks_iam_role_policies" {
  description = "Map of additioanl IAM role policy ARNs to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "create_service" {
  description = "Determines whether service resource will be created (set to `false` in case you want to create task definition only)"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnets to associate with the task or service"
  type        = list(string)
  default     = []
}

variable "timeouts" {
  description = "Create, update, and delete timeout configurations for the service"
  type        = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
}

variable "family" {
  description = "A unique name for your task definition"
  type        = string
  default     = null
}


output "name" {
  description = "Name of the service"
  value       = module.this.name
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.this.security_group_id
}

output "tasks_iam_role_name" {
  description = "Tasks IAM role name"
  value       = module.this.tasks_iam_role_name
}

output "task_set_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the task set"
  value       = module.this.task_set_arn
}

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.this.security_group_arn
}

output "infrastructure_iam_role_arn" {
  description = "Infrastructure IAM role ARN"
  value       = module.this.infrastructure_iam_role_arn
}

output "id" {
  description = "ARN that identifies the service"
  value       = module.this.id
}

output "task_exec_iam_role_arn" {
  description = "Task execution IAM role ARN"
  value       = module.this.task_exec_iam_role_arn
}

output "tasks_iam_role_arn" {
  description = "Tasks IAM role ARN"
  value       = module.this.tasks_iam_role_arn
}

output "infrastructure_iam_role_name" {
  description = "Infrastructure IAM role name"
  value       = module.this.infrastructure_iam_role_name
}

output "iam_role_arn" {
  description = "Service IAM role ARN"
  value       = module.this.iam_role_arn
}

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.this.task_definition_arn
}

output "task_exec_iam_role_name" {
  description = "Task execution IAM role name"
  value       = module.this.task_exec_iam_role_name
}

output "iam_role_name" {
  description = "Service IAM role name"
  value       = module.this.iam_role_name
}

output "iam_role_unique_id" {
  description = "Stable and unique string identifying the service IAM role"
  value       = module.this.iam_role_unique_id
}

output "task_exec_iam_role_unique_id" {
  description = "Stable and unique string identifying the task execution IAM role"
  value       = module.this.task_exec_iam_role_unique_id
}

output "tasks_iam_role_unique_id" {
  description = "Stable and unique string identifying the tasks IAM role"
  value       = module.this.tasks_iam_role_unique_id
}

output "task_set_id" {
  description = "The ID of the task set"
  value       = module.this.task_set_id
}
