# Governed wrapper around terraform-aws-modules/eks-pod-identity/aws.
# Archie governs this module's inputs; the module itself stays upstream and
# is upgraded by bumping the version below — not by re-importing a copy.
module "this" {
  source  = "terraform-aws-modules/eks-pod-identity/aws"
  version = "2.9.0"

  associations = var.associations
  aws_lb_controller_policy_name = var.aws_lb_controller_policy_name
  velero_policy_name = var.velero_policy_name
  velero_s3_bucket_path_arns = var.velero_s3_bucket_path_arns
  additional_policy_arns = var.additional_policy_arns
  external_dns_policy_name = var.external_dns_policy_name
  external_secrets_policy_name = var.external_secrets_policy_name
  aws_lb_controller_targetgroup_only_policy_name = var.aws_lb_controller_targetgroup_only_policy_name
  trust_policy_conditions = var.trust_policy_conditions
  name = var.name
  aws_efs_csi_policy_name = var.aws_efs_csi_policy_name
  aws_fsx_lustre_csi_service_role_arns = var.aws_fsx_lustre_csi_service_role_arns
  cert_manager_policy_name = var.cert_manager_policy_name
  cluster_autoscaler_policy_name = var.cluster_autoscaler_policy_name
  aws_global_accelerator_controller_policy_name = var.aws_global_accelerator_controller_policy_name
  tags = var.tags
  aws_ebs_csi_policy_name = var.aws_ebs_csi_policy_name
  aws_gateway_controller_policy_name = var.aws_gateway_controller_policy_name
  aws_node_termination_handler_policy_name = var.aws_node_termination_handler_policy_name
  aws_fsx_lustre_csi_policy_name = var.aws_fsx_lustre_csi_policy_name
  amazon_managed_service_prometheus_policy_name = var.amazon_managed_service_prometheus_policy_name
  appmesh_controller_policy_name = var.appmesh_controller_policy_name
  mountpoint_s3_csi_bucket_path_arns = var.mountpoint_s3_csi_bucket_path_arns
  association_defaults = var.association_defaults
  pganalyze_policy_name = var.pganalyze_policy_name
  attach_aws_lb_controller_policy = var.attach_aws_lb_controller_policy
  mountpoint_s3_csi_policy_name = var.mountpoint_s3_csi_policy_name
  appmesh_envoy_proxy_policy_name = var.appmesh_envoy_proxy_policy_name
  aws_privateca_issuer_policy_name = var.aws_privateca_issuer_policy_name
  description = var.description
  aws_vpc_cni_policy_name = var.aws_vpc_cni_policy_name
}


variable "associations" {
  description = "Map of Pod Identity associations to be created (map of maps)"
  type        = map(object({
    cluster_name         = optional(string)
    disable_session_tags = optional(bool)
    namespace            = optional(string)
    service_account      = optional(string)
    role_arn             = optional(string)
    target_role_arn      = optional(string)
    tags                 = optional(map(string), {})
  }))
  default     = {}
}

variable "aws_lb_controller_policy_name" {
  description = "Custom name of the AWS Load Balancer Controller IAM policy"
  type        = string
  default     = null
}

variable "velero_policy_name" {
  description = "Custom name of the Velero IAM policy"
  type        = string
  default     = null
}

variable "velero_s3_bucket_path_arns" {
  description = "S3 path ARNs to allow Velero to manage items at the provided path(s). This is required if `attach_mountpoint_s3_csi_policy = true`"
  type        = list(string)
  default     = []
}

variable "additional_policy_arns" {
  description = "ARNs of additional policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "external_dns_policy_name" {
  description = "Custom name of the External DNS IAM policy"
  type        = string
  default     = null
}

variable "external_secrets_policy_name" {
  description = "Custom name of the External Secrets IAM policy"
  type        = string
  default     = null
}

variable "aws_lb_controller_targetgroup_only_policy_name" {
  description = "Custom name of the AWS Load Balancer Controller IAM policy for the TargetGroupBinding only"
  type        = string
  default     = null
}

variable "trust_policy_conditions" {
  description = "A list of conditions to add to the role trust policy"
  type        = list(object({
    test     = string
    values   = list(string)
    variable = string
  }))
  default     = []
}

variable "name" {
  description = "Name of IAM role"
  type        = string
  default     = ""
}

variable "aws_efs_csi_policy_name" {
  description = "Custom name of the EFS CSI IAM policy"
  type        = string
  default     = null
}

variable "aws_fsx_lustre_csi_service_role_arns" {
  description = "Service role ARNs to allow FSx for Lustre CSI create and manage FSX for Lustre service linked roles"
  type        = list(string)
  default     = []
}

variable "cert_manager_policy_name" {
  description = "Custom name of the Cert Manager IAM policy"
  type        = string
  default     = null
}

variable "cluster_autoscaler_policy_name" {
  description = "Custom name of the Cluster Autoscaler IAM policy"
  type        = string
  default     = null
}

variable "aws_global_accelerator_controller_policy_name" {
  description = "Custom name of the AWS Global Accelerator Controller IAM policy"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "aws_ebs_csi_policy_name" {
  description = "Custom name of the EBS CSI IAM policy"
  type        = string
  default     = null
}

variable "aws_gateway_controller_policy_name" {
  description = "Custom name of the AWS Gateway Controller IAM policy"
  type        = string
  default     = null
}

variable "aws_node_termination_handler_policy_name" {
  description = "Custom name of the Node Termination Handler IAM policy"
  type        = string
  default     = null
}

variable "aws_fsx_lustre_csi_policy_name" {
  description = "Custom name of the FSx for Lustre CSI Driver IAM policy"
  type        = string
  default     = null
}

variable "amazon_managed_service_prometheus_policy_name" {
  description = "Custom name of the Amazon Managed Service for Prometheus IAM policy"
  type        = string
  default     = null
}

variable "appmesh_controller_policy_name" {
  description = "Custom name of the AppMesh Controller IAM policy"
  type        = string
  default     = null
}

variable "mountpoint_s3_csi_bucket_path_arns" {
  description = "S3 path ARNs to allow Mountpoint S3 CSI driver to manage items at the provided path(s). This is required if `attach_mountpoint_s3_csi_policy = true`"
  type        = list(string)
  default     = []
}

variable "association_defaults" {
  description = "Default values used across all Pod Identity associations created unless a more specific value is provided"
  type        = object({
    cluster_name         = optional(string)
    disable_session_tags = optional(bool)
    namespace            = optional(string)
    service_account      = optional(string)
    role_arn             = optional(string)
    target_role_arn      = optional(string)
    tags                 = optional(map(string), {})
  })
  default     = {}
}

variable "pganalyze_policy_name" {
  description = "Custom name of the PGAnalyze IAM policy"
  type        = string
  default     = null
}

variable "attach_aws_lb_controller_policy" {
  description = "Determines whether to attach the AWS Load Balancer Controller policy to the role"
  type        = bool
  default     = false
}

variable "mountpoint_s3_csi_policy_name" {
  description = "Custom name of the Mountpoint S3 CSI IAM policy"
  type        = string
  default     = null
}

variable "appmesh_envoy_proxy_policy_name" {
  description = "Custom name of the AppMesh Envoy Proxy IAM policy"
  type        = string
  default     = null
}

variable "aws_privateca_issuer_policy_name" {
  description = "Custom name of the AWS Private CA Issuer IAM policy"
  type        = string
  default     = null
}

variable "description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "aws_vpc_cni_policy_name" {
  description = "Custom name of the VPC CNI IAM policy"
  type        = string
  default     = null
}


output "iam_policy_id" {
  description = "The policy's ID"
  value       = module.this.iam_policy_id
  sensitive   = true
}

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.this.iam_role_arn
  sensitive   = true
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.this.iam_role_name
  sensitive   = true
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = module.this.iam_role_unique_id
  sensitive   = true
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.this.iam_policy_arn
  sensitive   = true
}

output "iam_policy_name" {
  description = "Name of IAM policy"
  value       = module.this.iam_policy_name
  sensitive   = true
}
