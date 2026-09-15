# Governed wrapper around terraform-aws-modules/vpc/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.2"

  enable_ipv6 = var.enable_ipv6
  flow_log_cloudwatch_log_group_kms_key_id = var.flow_log_cloudwatch_log_group_kms_key_id
  create_vpc = var.create_vpc
  azs = var.azs
  ipv4_ipam_pool_id = var.ipv4_ipam_pool_id
  default_vpc_name = var.default_vpc_name
  enable_network_address_usage_metrics = var.enable_network_address_usage_metrics
  enable_flow_log = var.enable_flow_log
  database_subnets = var.database_subnets
  create_igw = var.create_igw
  dhcp_options_domain_name = var.dhcp_options_domain_name
  create_multiple_intra_route_tables = var.create_multiple_intra_route_tables
  name = var.name
  create_database_subnet_route_table = var.create_database_subnet_route_table
  redshift_subnet_group_name = var.redshift_subnet_group_name
  create_egress_only_igw = var.create_egress_only_igw
  manage_default_route_table = var.manage_default_route_table
  default_security_group_name = var.default_security_group_name
  tags = var.tags
  cidr = var.cidr
  manage_default_vpc = var.manage_default_vpc
  create_database_nat_gateway_route = var.create_database_nat_gateway_route
  elasticache_subnets = var.elasticache_subnets
  elasticache_subnet_group_name = var.elasticache_subnet_group_name
  create_redshift_subnet_route_table = var.create_redshift_subnet_route_table
  ipv6_cidr = var.ipv6_cidr
  single_nat_gateway = var.single_nat_gateway
  create_elasticache_subnet_route_table = var.create_elasticache_subnet_route_table
  default_route_table_name = var.default_route_table_name
  create_elasticache_subnet_group = var.create_elasticache_subnet_group
  enable_nat_gateway = var.enable_nat_gateway
  nat_gateway_destination_cidr_block = var.nat_gateway_destination_cidr_block
  database_subnet_group_name = var.database_subnet_group_name
  enable_public_redshift = var.enable_public_redshift
  create_redshift_subnet_group = var.create_redshift_subnet_group
  create_flow_log_cloudwatch_log_group = var.create_flow_log_cloudwatch_log_group
  create_private_nat_gateway_route = var.create_private_nat_gateway_route
  enable_dns_support = var.enable_dns_support
  intra_subnets = var.intra_subnets
  vpn_gateway_id = var.vpn_gateway_id
  create_database_internet_gateway_route = var.create_database_internet_gateway_route
  manage_default_network_acl = var.manage_default_network_acl
  dhcp_options_netbios_node_type = var.dhcp_options_netbios_node_type
  manage_default_security_group = var.manage_default_security_group
  public_subnets = var.public_subnets
  create_database_subnet_group = var.create_database_subnet_group
  flow_log_cloudwatch_log_group_retention_in_days = var.flow_log_cloudwatch_log_group_retention_in_days
  create_flow_log_cloudwatch_iam_role = var.create_flow_log_cloudwatch_iam_role
  enable_vpn_gateway = var.enable_vpn_gateway
  enable_dns_hostnames = var.enable_dns_hostnames
  create_multiple_public_route_tables = var.create_multiple_public_route_tables
  enable_dhcp_options = var.enable_dhcp_options
  default_network_acl_name = var.default_network_acl_name
  outpost_subnets = var.outpost_subnets
  ipv6_ipam_pool_id = var.ipv6_ipam_pool_id
  private_subnets = var.private_subnets
  redshift_subnets = var.redshift_subnets
}


variable "enable_ipv6" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block"
  type        = bool
  default     = false
}

variable "flow_log_cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data for VPC flow logs"
  type        = string
  default     = null
}

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}

variable "ipv4_ipam_pool_id" {
  description = "(Optional) The ID of an IPv4 IPAM pool you want to use for allocating this VPC's CIDR"
  type        = string
  default     = null
}

variable "default_vpc_name" {
  description = "Name to be used on the Default VPC"
  type        = string
  default     = null
}

variable "enable_network_address_usage_metrics" {
  description = "Determines whether network address usage metrics are enabled for the VPC"
  type        = bool
  default     = null
}

variable "enable_flow_log" {
  description = "Whether or not to enable VPC Flow Logs"
  type        = bool
  default     = false
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_igw" {
  description = "Controls if an Internet Gateway is created for public subnets and the related routes that connect them"
  type        = bool
  default     = true
}

variable "dhcp_options_domain_name" {
  description = "Specifies DNS name for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "create_multiple_intra_route_tables" {
  description = "Indicates whether to create a separate route table for each intra subnet. Default: `false`"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "create_database_subnet_route_table" {
  description = "Controls if separate route table for database should be created"
  type        = bool
  default     = false
}

variable "redshift_subnet_group_name" {
  description = "Name of redshift subnet group"
  type        = string
  default     = null
}

variable "create_egress_only_igw" {
  description = "Controls if an Egress Only Internet Gateway is created and its related routes"
  type        = bool
  default     = true
}

variable "manage_default_route_table" {
  description = "Should be true to manage default route table"
  type        = bool
  default     = true
}

variable "default_security_group_name" {
  description = "Name to be used on the default security group"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cidr" {
  description = "(Optional) The IPv4 CIDR block for the VPC. CIDR can be explicitly set or it can be derived from IPAM using `ipv4_netmask_length` & `ipv4_ipam_pool_id`"
  type        = string
  default     = "10.0.0.0/16"
}

variable "manage_default_vpc" {
  description = "Should be true to adopt and manage Default VPC"
  type        = bool
  default     = false
}

variable "create_database_nat_gateway_route" {
  description = "Controls if a nat gateway route should be created to give internet access to the database subnets"
  type        = bool
  default     = false
}

variable "elasticache_subnets" {
  description = "A list of elasticache subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "elasticache_subnet_group_name" {
  description = "Name of elasticache subnet group"
  type        = string
  default     = null
}

variable "create_redshift_subnet_route_table" {
  description = "Controls if separate route table for redshift should be created"
  type        = bool
  default     = false
}

variable "ipv6_cidr" {
  description = "(Optional) IPv6 CIDR block to request from an IPAM Pool. Can be set explicitly or derived from IPAM using `ipv6_netmask_length`"
  type        = string
  default     = null
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "create_elasticache_subnet_route_table" {
  description = "Controls if separate route table for elasticache should be created"
  type        = bool
  default     = false
}

variable "default_route_table_name" {
  description = "Name to be used on the default route table"
  type        = string
  default     = null
}

variable "create_elasticache_subnet_group" {
  description = "Controls if elasticache subnet group should be created"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
  type        = bool
  default     = false
}

variable "nat_gateway_destination_cidr_block" {
  description = "Used to pass a custom destination route for private NAT Gateway. If not specified, the default 0.0.0.0/0 is used as a destination route"
  type        = string
  default     = "0.0.0.0/0"
}

variable "database_subnet_group_name" {
  description = "Name of database subnet group"
  type        = string
  default     = null
}

variable "enable_public_redshift" {
  description = "Controls if redshift should have public routing table"
  type        = bool
  default     = false
}

variable "create_redshift_subnet_group" {
  description = "Controls if redshift subnet group should be created"
  type        = bool
  default     = true
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "create_private_nat_gateway_route" {
  description = "Controls if a nat gateway route should be created to give internet access to the private subnets"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "intra_subnets" {
  description = "A list of intra subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "vpn_gateway_id" {
  description = "ID of VPN Gateway to attach to the VPC"
  type        = string
  default     = ""
}

variable "create_database_internet_gateway_route" {
  description = "Controls if an internet gateway route for public database access should be created"
  type        = bool
  default     = false
}

variable "manage_default_network_acl" {
  description = "Should be true to adopt and manage Default Network ACL"
  type        = bool
  default     = true
}

variable "dhcp_options_netbios_node_type" {
  description = "Specify netbios node_type for DHCP options set (requires enable_dhcp_options set to true)"
  type        = string
  default     = ""
}

variable "manage_default_security_group" {
  description = "Should be true to adopt and manage default security group"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_database_subnet_group" {
  description = "Controls if database subnet group should be created (n.b. database_subnets must also be set)"
  type        = bool
  default     = true
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs"
  type        = number
  default     = null
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs"
  type        = bool
  default     = false
}

variable "enable_vpn_gateway" {
  description = "Should be true if you want to create a new VPN Gateway resource and attach it to the VPC"
  type        = bool
  default     = false
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "create_multiple_public_route_tables" {
  description = "Indicates whether to create a separate route table for each public subnet. Default: `false`"
  type        = bool
  default     = false
}

variable "enable_dhcp_options" {
  description = "Should be true if you want to specify a DHCP options set with a custom domain name, DNS servers, NTP servers, netbios servers, and/or netbios server type"
  type        = bool
  default     = false
}

variable "default_network_acl_name" {
  description = "Name to be used on the Default Network ACL"
  type        = string
  default     = null
}

variable "outpost_subnets" {
  description = "A list of outpost subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "ipv6_ipam_pool_id" {
  description = "(Optional) IPAM Pool ID for a IPv6 pool. Conflicts with `assign_generated_ipv6_cidr_block`"
  type        = string
  default     = null
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "redshift_subnets" {
  description = "A list of redshift subnets inside the VPC"
  type        = list(string)
  default     = []
}


output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.this.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.this.public_subnets
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = module.this.name
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.this.vpc_id
}

output "database_internet_gateway_route_id" {
  description = "ID of the database internet gateway route"
  value       = module.this.database_internet_gateway_route_id
}

output "redshift_subnet_arns" {
  description = "List of ARNs of redshift subnets"
  value       = module.this.redshift_subnet_arns
}

output "elasticache_route_table_ids" {
  description = "List of IDs of elasticache route tables"
  value       = module.this.elasticache_route_table_ids
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = module.this.vpc_ipv6_association_id
}

output "outpost_network_acl_id" {
  description = "ID of the outpost network ACL"
  value       = module.this.outpost_network_acl_id
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = module.this.vpc_main_route_table_id
}

output "private_ipv6_egress_route_ids" {
  description = "List of IDs of the ipv6 egress route"
  value       = module.this.private_ipv6_egress_route_ids
}

output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value       = module.this.public_network_acl_id
}

output "database_network_acl_arn" {
  description = "ARN of the database network ACL"
  value       = module.this.database_network_acl_arn
}

output "outpost_subnet_arns" {
  description = "List of ARNs of outpost subnets"
  value       = module.this.outpost_subnet_arns
}

output "database_network_acl_id" {
  description = "ID of the database network ACL"
  value       = module.this.database_network_acl_id
}

output "elasticache_route_table_association_ids" {
  description = "List of IDs of the elasticache route table association"
  value       = module.this.elasticache_route_table_association_ids
}

output "vgw_id" {
  description = "The ID of the VPN Gateway"
  value       = module.this.vgw_id
}

output "database_subnet_arns" {
  description = "List of ARNs of database subnets"
  value       = module.this.database_subnet_arns
}

output "database_subnet_group_name" {
  description = "Name of database subnet group"
  value       = module.this.database_subnet_group_name
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = module.this.private_route_table_ids
}

output "redshift_network_acl_arn" {
  description = "ARN of the redshift network ACL"
  value       = module.this.redshift_network_acl_arn
}

output "intra_route_table_ids" {
  description = "List of IDs of intra route tables"
  value       = module.this.intra_route_table_ids
}

output "default_vpc_id" {
  description = "The ID of the Default VPC"
  value       = module.this.default_vpc_id
}

output "outpost_network_acl_arn" {
  description = "ARN of the outpost network ACL"
  value       = module.this.outpost_network_acl_arn
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = module.this.nat_ids
}

output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = module.this.public_route_table_association_ids
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.this.vpc_arn
}

output "public_internet_gateway_ipv6_route_id" {
  description = "ID of the IPv6 internet gateway route"
  value       = module.this.public_internet_gateway_ipv6_route_id
}

output "cgw_ids" {
  description = "List of IDs of Customer Gateway"
  value       = module.this.cgw_ids
}

output "private_network_acl_arn" {
  description = "ARN of the private network ACL"
  value       = module.this.private_network_acl_arn
}

output "default_vpc_arn" {
  description = "The ARN of the Default VPC"
  value       = module.this.default_vpc_arn
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.this.public_route_table_ids
}

output "redshift_route_table_association_ids" {
  description = "List of IDs of the redshift route table association"
  value       = module.this.redshift_route_table_association_ids
}

output "elasticache_network_acl_id" {
  description = "ID of the elasticache network ACL"
  value       = module.this.elasticache_network_acl_id
}

output "dhcp_options_id" {
  description = "The ID of the DHCP options"
  value       = module.this.dhcp_options_id
}

output "database_route_table_association_ids" {
  description = "List of IDs of the database route table association"
  value       = module.this.database_route_table_association_ids
}

output "redshift_public_route_table_association_ids" {
  description = "List of IDs of the public redshift route table association"
  value       = module.this.redshift_public_route_table_association_ids
}

output "intra_route_table_association_ids" {
  description = "List of IDs of the intra route table association"
  value       = module.this.intra_route_table_association_ids
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = module.this.vpc_owner_id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = module.this.public_subnet_arns
}

output "database_nat_gateway_route_ids" {
  description = "List of IDs of the database nat gateway route"
  value       = module.this.database_nat_gateway_route_ids
}

output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route"
  value       = module.this.public_internet_gateway_route_id
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = module.this.igw_arn
}

output "public_network_acl_arn" {
  description = "ARN of the public network ACL"
  value       = module.this.public_network_acl_arn
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = module.this.private_subnet_arns
}

output "redshift_route_table_ids" {
  description = "List of IDs of redshift route tables"
  value       = module.this.redshift_route_table_ids
}

output "intra_network_acl_id" {
  description = "ID of the intra network ACL"
  value       = module.this.intra_network_acl_id
}

output "intra_network_acl_arn" {
  description = "ARN of the intra network ACL"
  value       = module.this.intra_network_acl_arn
}

output "default_vpc_default_security_group_id" {
  description = "The ID of the security group created by default on Default VPC creation"
  value       = module.this.default_vpc_default_security_group_id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.this.igw_id
}

output "private_nat_gateway_route_ids" {
  description = "List of IDs of the private nat gateway route"
  value       = module.this.private_nat_gateway_route_ids
}

output "redshift_network_acl_id" {
  description = "ID of the redshift network ACL"
  value       = module.this.redshift_network_acl_id
}

output "elasticache_subnet_group_name" {
  description = "Name of elasticache subnet group"
  value       = module.this.elasticache_subnet_group_name
}

output "vpc_flow_log_id" {
  description = "The ID of the Flow Log resource"
  value       = module.this.vpc_flow_log_id
}

output "vpc_flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
  value       = module.this.vpc_flow_log_cloudwatch_iam_role_arn
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = module.this.default_network_acl_id
}

output "default_vpc_default_route_table_id" {
  description = "The ID of the default route table of the Default VPC"
  value       = module.this.default_vpc_default_route_table_id
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.this.default_security_group_id
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = module.this.default_route_table_id
}

output "default_vpc_default_network_acl_id" {
  description = "The ID of the default network ACL of the Default VPC"
  value       = module.this.default_vpc_default_network_acl_id
}

output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = module.this.private_route_table_association_ids
}

output "database_ipv6_egress_route_id" {
  description = "ID of the database IPv6 egress route"
  value       = module.this.database_ipv6_egress_route_id
}

output "elasticache_subnet_arns" {
  description = "List of ARNs of elasticache subnets"
  value       = module.this.elasticache_subnet_arns
}

output "vpc_flow_log_destination_arn" {
  description = "The ARN of the destination for VPC Flow Logs"
  value       = module.this.vpc_flow_log_destination_arn
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value       = module.this.private_network_acl_id
}

output "database_route_table_ids" {
  description = "List of IDs of database route tables"
  value       = module.this.database_route_table_ids
}

output "intra_subnet_arns" {
  description = "List of ARNs of intra subnets"
  value       = module.this.intra_subnet_arns
}

output "cgw_arns" {
  description = "List of ARNs of Customer Gateway"
  value       = module.this.cgw_arns
}

output "default_vpc_main_route_table_id" {
  description = "The ID of the main route table associated with the Default VPC"
  value       = module.this.default_vpc_main_route_table_id
}

output "natgw_interface_ids" {
  description = "List of Network Interface IDs assigned to NAT Gateways"
  value       = module.this.natgw_interface_ids
}

output "vgw_arn" {
  description = "The ARN of the VPN Gateway"
  value       = module.this.vgw_arn
}

output "elasticache_network_acl_arn" {
  description = "ARN of the elasticache network ACL"
  value       = module.this.elasticache_network_acl_arn
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.this.natgw_ids
}

output "egress_only_internet_gateway_id" {
  description = "The ID of the egress only Internet Gateway"
  value       = module.this.egress_only_internet_gateway_id
}

output "intra_subnets" {
  description = "List of IDs of intra subnets"
  value       = module.this.intra_subnets
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = module.this.public_subnets_cidr_blocks
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = module.this.private_subnets_ipv6_cidr_blocks
}

output "outpost_subnets_cidr_blocks" {
  description = "List of cidr_blocks of outpost subnets"
  value       = module.this.outpost_subnets_cidr_blocks
}

output "elasticache_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of elasticache subnets in an IPv6 enabled VPC"
  value       = module.this.elasticache_subnets_ipv6_cidr_blocks
}

output "database_subnet_group" {
  description = "ID of database subnet group"
  value       = module.this.database_subnet_group
}

output "elasticache_subnet_group" {
  description = "ID of elasticache subnet group"
  value       = module.this.elasticache_subnet_group
}

output "redshift_subnets" {
  description = "List of IDs of redshift subnets"
  value       = module.this.redshift_subnets
}

output "redshift_subnets_cidr_blocks" {
  description = "List of cidr_blocks of redshift subnets"
  value       = module.this.redshift_subnets_cidr_blocks
}

output "vpc_secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks of the VPC"
  value       = module.this.vpc_secondary_cidr_blocks
}

output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.this.azs
}

output "outpost_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of outpost subnets in an IPv6 enabled VPC"
  value       = module.this.outpost_subnets_ipv6_cidr_blocks
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.this.nat_public_ips
}

output "default_vpc_cidr_block" {
  description = "The CIDR block of the Default VPC"
  value       = module.this.default_vpc_cidr_block
}

output "database_subnets_cidr_blocks" {
  description = "List of cidr_blocks of database subnets"
  value       = module.this.database_subnets_cidr_blocks
}

output "elasticache_subnets_cidr_blocks" {
  description = "List of cidr_blocks of elasticache subnets"
  value       = module.this.elasticache_subnets_cidr_blocks
}

output "elasticache_subnets" {
  description = "List of IDs of elasticache subnets"
  value       = module.this.elasticache_subnets
}

output "redshift_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of redshift subnets in an IPv6 enabled VPC"
  value       = module.this.redshift_subnets_ipv6_cidr_blocks
}

output "intra_subnets_cidr_blocks" {
  description = "List of cidr_blocks of intra subnets"
  value       = module.this.intra_subnets_cidr_blocks
}

output "intra_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of intra subnets in an IPv6 enabled VPC"
  value       = module.this.intra_subnets_ipv6_cidr_blocks
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = module.this.public_subnets_ipv6_cidr_blocks
}

output "database_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of database subnets in an IPv6 enabled VPC"
  value       = module.this.database_subnets_ipv6_cidr_blocks
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.this.vpc_cidr_block
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = module.this.vpc_ipv6_cidr_block
}

output "redshift_subnet_group" {
  description = "ID of redshift subnet group"
  value       = module.this.redshift_subnet_group
}

output "outpost_subnets" {
  description = "List of IDs of outpost subnets"
  value       = module.this.outpost_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.this.database_subnets
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = module.this.private_subnets_cidr_blocks
}
