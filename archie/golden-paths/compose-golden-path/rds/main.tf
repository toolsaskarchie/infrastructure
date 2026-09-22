# Governed wrapper around terraform-aws-modules/rds/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/rds/aws"
  version = "7.2.2"

  parameter_group_name = var.parameter_group_name
  master_user_secret_kms_key_id = var.master_user_secret_kms_key_id
  create_db_subnet_group = var.create_db_subnet_group
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  allocated_storage = var.allocated_storage
  replica_mode = var.replica_mode
  snapshot_identifier = var.snapshot_identifier
  family = var.family
  engine_version = var.engine_version
  db_subnet_group_name = var.db_subnet_group_name
  create_db_option_group = var.create_db_option_group
  publicly_accessible = var.publicly_accessible
  option_group_name = var.option_group_name
  backup_retention_period = var.backup_retention_period
  username = var.username
  multi_az = var.multi_az
  major_engine_version = var.major_engine_version
  create_db_instance = var.create_db_instance
  manage_master_user_password = var.manage_master_user_password
  performance_insights_enabled = var.performance_insights_enabled
  create_cloudwatch_log_group = var.create_cloudwatch_log_group
  character_set_name = var.character_set_name
  identifier = var.identifier
  create_db_parameter_group = var.create_db_parameter_group
  max_allocated_storage = var.max_allocated_storage
  customer_owned_ip_enabled = var.customer_owned_ip_enabled
  db_instance_role_associations = var.db_instance_role_associations
  cloudwatch_log_group_kms_key_id = var.cloudwatch_log_group_kms_key_id
  nchar_character_set_name = var.nchar_character_set_name
  timeouts = var.timeouts
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  engine = var.engine
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_ids = var.subnet_ids
  kms_key_id = var.kms_key_id
  domain_iam_role_name = var.domain_iam_role_name
  deletion_protection = var.deletion_protection
  db_name = var.db_name
  performance_insights_kms_key_id = var.performance_insights_kms_key_id
  ca_cert_identifier = var.ca_cert_identifier
  storage_encrypted = var.storage_encrypted
  instance_class = var.instance_class
  create_monitoring_role = var.create_monitoring_role
  database_insights_mode = var.database_insights_mode
  manage_master_user_password_rotation = var.manage_master_user_password_rotation
  tags = var.tags
}


variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate or create"
  type        = string
  default     = null
}

variable "master_user_secret_kms_key_id" {
  description = "The key ARN, key ID, alias ARN or alias name for the KMS key to encrypt the master user password secret in Secrets Manager. If not specified, the default KMS key for your Amazon Web Services account i"
  type        = string
  default     = null
}

variable "create_db_subnet_group" {
  description = "Whether to create a database subnet group"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain CloudWatch logs for the DB instance"
  type        = number
  default     = 7
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = null
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specifi"
  type        = string
  default     = null
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05"
  type        = string
  default     = null
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
  default     = null
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = null
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  type        = string
  default     = null
}

variable "create_db_option_group" {
  description = "Create a database option group"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "option_group_name" {
  description = "Name of the option group"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = null
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
  type        = string
  default     = null
}

variable "create_db_instance" {
  description = "Whether to create a database instance"
  type        = bool
  default     = true
}

variable "manage_master_user_password" {
  description = "Set to true to allow RDS to manage the master user password in Secrets Manager"
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights are enabled"
  type        = bool
  default     = false
}

variable "create_cloudwatch_log_group" {
  description = "Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports`"
  type        = bool
  default     = false
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS and Collations and Character Sets for Microsoft SQL Server f"
  type        = string
  default     = null
}

variable "identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "create_db_parameter_group" {
  description = "Whether to create a database parameter group"
  type        = bool
  default     = true
}

variable "max_allocated_storage" {
  description = "Specifies the value for Storage Autoscaling"
  type        = number
  default     = 0
}

variable "customer_owned_ip_enabled" {
  description = "Indicates whether to enable a customer-owned IP address (CoIP) for an RDS on Outposts DB instance"
  type        = bool
  default     = null
}

variable "db_instance_role_associations" {
  description = "A map of DB instance supported feature name to role association ARNs."
  type        = map(string)
  default     = {}
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
  default     = null
}

variable "nchar_character_set_name" {
  description = "The national character set is used in the NCHAR, NVARCHAR2, and NCLOB data types for Oracle instances. This can't be changed."
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times"
  type        = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or not the mappings of AWS Identity and Access Management (IAM) accounts to database accounts are enabled"
  type        = bool
  default     = false
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
  default     = []
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key creat"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  type        = string
  default     = null
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = true
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = null
}

variable "create_monitoring_role" {
  description = "Create IAM role with a defined name that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = bool
  default     = false
}

variable "database_insights_mode" {
  description = "The mode of Database Insights that is enabled for the instance. Valid values: standard, advanced"
  type        = string
  default     = null
}

variable "manage_master_user_password_rotation" {
  description = "Whether to manage the master user password rotation. By default, false on creation, rotation is managed by RDS. There is not currently a way to disable this on initial creation even when set to false."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}


output "db_listener_endpoint" {
  description = "Specifies the listener connection endpoint for SQL Server Always On"
  value       = module.this.db_listener_endpoint
}

output "db_parameter_group_arn" {
  description = "The ARN of the db parameter group"
  value       = module.this.db_parameter_group_arn
}

output "db_instance_resource_id" {
  description = "The RDS Resource ID of this instance"
  value       = module.this.db_instance_resource_id
}

output "db_instance_domain_iam_role_name" {
  description = "The name of the IAM role to be used when making API calls to the Directory Service"
  value       = module.this.db_instance_domain_iam_role_name
}

output "db_option_group_arn" {
  description = "The ARN of the db option group"
  value       = module.this.db_option_group_arn
}

output "db_instance_master_user_secret_arn" {
  description = "The ARN of the master user secret (Only available when manage_master_user_password is set to true)"
  value       = module.this.db_instance_master_user_secret_arn
}

output "db_option_group_id" {
  description = "The db option group id"
  value       = module.this.db_option_group_id
}

output "enhanced_monitoring_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the monitoring role"
  value       = module.this.enhanced_monitoring_iam_role_arn
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = module.this.db_instance_arn
}

output "db_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = module.this.db_instance_hosted_zone_id
}

output "db_instance_name" {
  description = "The database name"
  value       = module.this.db_instance_name
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = module.this.db_instance_endpoint
}

output "db_subnet_group_id" {
  description = "The db subnet group name"
  value       = module.this.db_subnet_group_id
}

output "db_subnet_group_arn" {
  description = "The ARN of the db subnet group"
  value       = module.this.db_subnet_group_arn
}

output "enhanced_monitoring_iam_role_name" {
  description = "The name of the monitoring role"
  value       = module.this.enhanced_monitoring_iam_role_name
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = module.this.db_instance_address
}

output "db_instance_domain_auth_secret_arn" {
  description = "The ARN for the Secrets Manager secret with the self managed Active Directory credentials for the user joining the domain"
  value       = module.this.db_instance_domain_auth_secret_arn
}

output "db_parameter_group_id" {
  description = "The db parameter group id"
  value       = module.this.db_parameter_group_id
}

output "db_instance_cloudwatch_log_groups" {
  description = "Map of CloudWatch log groups created and their attributes"
  value       = module.this.db_instance_cloudwatch_log_groups
}

output "db_instance_domain_fqdn" {
  description = "The fully qualified domain name (FQDN) of an self managed Active Directory domain"
  value       = module.this.db_instance_domain_fqdn
}

output "db_instance_port" {
  description = "The database port"
  value       = module.this.db_instance_port
}

output "db_instance_availability_zone" {
  description = "The availability zone of the RDS instance"
  value       = module.this.db_instance_availability_zone
}

output "db_instance_domain_dns_ips" {
  description = "The IPv4 DNS IP addresses of your primary and secondary self managed Active Directory domain controllers"
  value       = module.this.db_instance_domain_dns_ips
}
