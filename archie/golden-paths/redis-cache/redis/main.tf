# Governed wrapper around terraform-aws-modules/elasticache/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/elasticache/aws"
  version = "1.11.1"

  timeouts = var.timeouts
  tags = var.tags
  multi_az_enabled = var.multi_az_enabled
  security_group_rules = var.security_group_rules
  security_group_ids = var.security_group_ids
  create_security_group = var.create_security_group
  transit_encryption_enabled = var.transit_encryption_enabled
  security_group_name = var.security_group_name
  node_type = var.node_type
  kms_key_arn = var.kms_key_arn
  cluster_mode_enabled = var.cluster_mode_enabled
  create_secondary_global_replication_group = var.create_secondary_global_replication_group
  create_parameter_group = var.create_parameter_group
  parameter_group_name = var.parameter_group_name
  automatic_failover_enabled = var.automatic_failover_enabled
  engine_version = var.engine_version
  final_snapshot_identifier = var.final_snapshot_identifier
  snapshot_name = var.snapshot_name
  subnet_group_name = var.subnet_group_name
  outpost_mode = var.outpost_mode
  preferred_cache_cluster_azs = var.preferred_cache_cluster_azs
  snapshot_retention_limit = var.snapshot_retention_limit
  data_tiering_enabled = var.data_tiering_enabled
  description = var.description
  create_subnet_group = var.create_subnet_group
  subnet_ids = var.subnet_ids
  vpc_id = var.vpc_id
  cluster_id = var.cluster_id
  preferred_availability_zones = var.preferred_availability_zones
  transit_encryption_mode = var.transit_encryption_mode
  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  global_replication_group_id = var.global_replication_group_id
  create_primary_global_replication_group = var.create_primary_global_replication_group
  az_mode = var.az_mode
  create_replication_group = var.create_replication_group
  cluster_mode = var.cluster_mode
  replication_group_id = var.replication_group_id
  create_cluster = var.create_cluster
}


variable "timeouts" {
  description = "Define maximum timeout for creating, updating, and deleting cluster resource"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "multi_az_enabled" {
  description = "Specifies whether to enable Multi-AZ Support for the replication group. If true, `automatic_failover_enabled` must also be enabled. Defaults to `false`"
  type        = bool
  default     = false
}

variable "security_group_rules" {
  description = "Security group ingress and egress rules to add to the security group created"
  type        = any
  default     = {}
}

variable "security_group_ids" {
  description = "One or more VPC security groups associated with the cache cluster"
  type        = list(string)
  default     = []
}

variable "create_security_group" {
  description = "Determines if a security group is created"
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "Enable encryption in-transit"
  type        = bool
  default     = true
}

variable "security_group_name" {
  description = "Name to use on security group created"
  type        = string
  default     = null
}

variable "node_type" {
  description = "The instance class used. For Memcached, changing this value will re-create the resource"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if `at_rest_encryption_enabled = true`"
  type        = string
  default     = null
}

variable "cluster_mode_enabled" {
  description = "Whether to enable Redis [cluster mode https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Replication.Redis-RedisCluster.html]"
  type        = bool
  default     = false
}

variable "create_secondary_global_replication_group" {
  description = "Determines whether an secondary ElastiCache global replication group will be created"
  type        = bool
  default     = false
}

variable "create_parameter_group" {
  description = "Determines whether the ElastiCache parameter group will be created or not"
  type        = bool
  default     = false
}

variable "parameter_group_name" {
  description = "The name of the parameter group. If `create_parameter_group` is `true`, this is the name assigned to the parameter group created. Otherwise, this is the name of an existing parameter group"
  type        = string
  default     = null
}

variable "automatic_failover_enabled" {
  description = "Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is"
  type        = bool
  default     = null
}

variable "engine_version" {
  description = "Version number of the cache engine to be used. If not set, defaults to the latest version"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "(Redis only) Name of your final cluster snapshot. If omitted, no final snapshot will be made"
  type        = string
  default     = null
}

variable "snapshot_name" {
  description = "(Redis only) Name of a snapshot from which to restore data into the new node group. Changing `snapshot_name` forces a new resource"
  type        = string
  default     = null
}

variable "subnet_group_name" {
  description = "The name of the subnet group. If `create_subnet_group` is `true`, this is the name assigned to the subnet group created. Otherwise, this is the name of an existing subnet group"
  type        = string
  default     = null
}

variable "outpost_mode" {
  description = "Specify the outpost mode that will apply to the cache cluster creation. Valid values are `single-outpost` and `cross-outpost`, however AWS currently only supports `single-outpost` mode"
  type        = string
  default     = null
}

variable "preferred_cache_cluster_azs" {
  description = "List of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is considered. The first item in the list will be the pr"
  type        = list(string)
  default     = []
}

variable "snapshot_retention_limit" {
  description = "(Redis only) Number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them"
  type        = number
  default     = null
}

variable "data_tiering_enabled" {
  description = "Enables data tiering. Data tiering is only supported for replication groups using the `r6gd` node type. This parameter must be set to true when using `r6gd` nodes"
  type        = bool
  default     = null
}

variable "description" {
  description = "User-created description for the replication group"
  type        = string
  default     = null
}

variable "create_subnet_group" {
  description = "Determines whether the Elasticache subnet group will be created or not"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of VPC Subnet IDs for the Elasticache subnet group"
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  description = "Identifier of the VPC where the security group will be created"
  type        = string
  default     = null
}

variable "cluster_id" {
  description = "Group identifier. ElastiCache converts this name to lowercase. Changing this value will re-create the resource"
  type        = string
  default     = ""
}

variable "preferred_availability_zones" {
  description = "List of the Availability Zones in which cache nodes are created"
  type        = list(string)
  default     = []
}

variable "transit_encryption_mode" {
  description = "A setting that enables clients to migrate to in-transit encryption with no downtime. Valid values are `preferred` and `required`"
  type        = string
  default     = null
}

variable "at_rest_encryption_enabled" {
  description = "Whether to enable encryption at rest"
  type        = bool
  default     = true
}

variable "global_replication_group_id" {
  description = "The ID of the global replication group to which this replication group should belong"
  type        = string
  default     = null
}

variable "create_primary_global_replication_group" {
  description = "Determines whether an primary ElastiCache global replication group will be created"
  type        = bool
  default     = false
}

variable "az_mode" {
  description = "Whether the nodes in this Memcached node group are created in a single Availability Zone or created across multiple Availability Zones in the cluster's region. Valid values for this parameter are `sin"
  type        = string
  default     = null
}

variable "create_replication_group" {
  description = "Determines whether an ElastiCache replication group will be created or not"
  type        = bool
  default     = true
}

variable "cluster_mode" {
  description = "Specifies whether cluster mode is enabled or disabled. Valid values are enabled or disabled or compatible"
  type        = string
  default     = null
}

variable "replication_group_id" {
  description = "Replication group identifier. When `create_replication_group` is set to `true`, this is the ID assigned to the replication group created. When `create_replication_group` is set to `false`, this is the"
  type        = string
}

variable "create_cluster" {
  description = "Determines whether an ElastiCache cluster will be created or not"
  type        = bool
  default     = false
}


output "security_group_id" {
  description = "ID of the security group"
  value       = module.this.security_group_id
}

output "subnet_group_name" {
  description = "The ElastiCache subnet group name"
  value       = module.this.subnet_group_name
}

output "cluster_configuration_endpoint" {
  description = "(Memcached only) Configuration endpoint to allow host discovery"
  value       = module.this.cluster_configuration_endpoint
}

output "global_replication_group_arn" {
  description = "ARN of the created ElastiCache Global Replication Group"
  value       = module.this.global_replication_group_arn
}

output "cloudwatch_log_group_name" {
  description = "Name of cloudwatch log group created"
  value       = module.this.cloudwatch_log_group_name
}

output "replication_group_id" {
  description = "ID of the ElastiCache Replication Group"
  value       = module.this.replication_group_id
}

output "replication_group_reader_endpoint_address" {
  description = "Address of the endpoint for the reader node in the replication group, if the cluster mode is disabled"
  value       = module.this.replication_group_reader_endpoint_address
}

output "parameter_group_id" {
  description = "The ElastiCache parameter group name"
  value       = module.this.parameter_group_id
}

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.this.security_group_arn
}

output "cluster_arn" {
  description = "The ARN of the ElastiCache Cluster"
  value       = module.this.cluster_arn
}

output "replication_group_arn" {
  description = "ARN of the created ElastiCache Replication Group"
  value       = module.this.replication_group_arn
}

output "replication_group_primary_endpoint_address" {
  description = "Address of the endpoint for the primary node in the replication group, if the cluster mode is disabled"
  value       = module.this.replication_group_primary_endpoint_address
}

output "global_replication_group_id" {
  description = "ID of the ElastiCache Global Replication Group"
  value       = module.this.global_replication_group_id
}

output "cloudwatch_log_group_arn" {
  description = "Arn of cloudwatch log group created"
  value       = module.this.cloudwatch_log_group_arn
}

output "parameter_group_arn" {
  description = "The AWS ARN associated with the parameter group"
  value       = module.this.parameter_group_arn
}

output "replication_group_configuration_endpoint_address" {
  description = "Address of the replication group configuration endpoint when cluster mode is enabled"
  value       = module.this.replication_group_configuration_endpoint_address
}

output "cluster_address" {
  description = "(Memcached only) DNS name of the cache cluster without the port appended"
  value       = module.this.cluster_address
}

output "replication_group_port" {
  description = "Port of the primary node in the replication group, if the cluster mode is disabled"
  value       = module.this.replication_group_port
}

output "global_replication_group_node_groups" {
  description = "Set of node groups (shards) on the global replication group"
  value       = module.this.global_replication_group_node_groups
}

output "cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.this.cloudwatch_log_groups
}
