# An AgentCore runtime: the managed microVM that runs an agent container, the
# role it runs as, and a named endpoint callers invoke.
#
# The container is the developer's. A runtime cannot stand up without an image,
# so `container_image` has no default: it must already be in ECR when this
# applies.

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.9"
    }
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_partition" "current" {}

locals {
  account   = data.aws_caller_identity.current.account_id
  region    = data.aws_region.current.region
  partition = data.aws_partition.current.partition

  # AgentCore names allow letters, digits and underscores only.
  base          = replace("${var.project}_${var.environment}", "/[^a-zA-Z0-9_]/", "_")
  runtime_name  = substr("${local.base}_agent", 0, 48)
  endpoint_name = substr("${local.base}_endpoint", 0, 48)

  # The image's own repository, read out of its URI, so the role can pull the
  # image it was given and nothing else. A registry built alongside is added so
  # images pushed there later can be rolled out without touching IAM.
  image_host     = split("/", var.container_image)[0]
  image_account  = split(".", local.image_host)[0]
  image_region   = split(".", local.image_host)[3]
  image_repo     = split("@", split(":", join("/", slice(split("/", var.container_image), 1, length(split("/", var.container_image)))))[0])[0]
  image_repo_arn = "arn:${local.partition}:ecr:${local.image_region}:${local.image_account}:repository/${local.image_repo}"
  pull_repo_arns = distinct(compact([local.image_repo_arn, var.registry_arn]))

  runtime_arn_pattern = "arn:${local.partition}:bedrock-agentcore:${local.region}:${local.account}:*"

  env = merge(var.environment_variables, {
    MODEL_ID    = var.model_id
    ENVIRONMENT = var.environment
    }, var.memory_id == null ? {} : {
    MEMORY_ID = var.memory_id
  })
}

resource "aws_iam_role" "agent" {
  name = substr("${var.project}-${var.environment}-agentcore", 0, 64)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "bedrock-agentcore.amazonaws.com" }
      Action    = "sts:AssumeRole"
      Condition = {
        StringEquals = { "aws:SourceAccount" = local.account }
        ArnLike      = { "aws:SourceArn" = local.runtime_arn_pattern }
      }
    }]
  })
  tags = var.tags
}

resource "aws_iam_role_policy" "agent" {
  name = "agentcore-runtime"
  role = aws_iam_role.agent.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat([
      {
        Sid      = "PullAgentImage"
        Effect   = "Allow"
        Action   = ["ecr:BatchGetImage", "ecr:GetDownloadUrlForLayer"]
        Resource = local.pull_repo_arns
      },
      {
        Sid      = "EcrToken"
        Effect   = "Allow"
        Action   = ["ecr:GetAuthorizationToken"]
        Resource = "*"
      },
      {
        Sid    = "InvokeModels"
        Effect = "Allow"
        Action = ["bedrock:InvokeModel", "bedrock:InvokeModelWithResponseStream"]
        Resource = [
          "arn:${local.partition}:bedrock:*::foundation-model/*",
          "arn:${local.partition}:bedrock:*:${local.account}:inference-profile/*",
        ]
      },
      {
        Sid    = "RuntimeLogs"
        Effect = "Allow"
        Action = ["logs:CreateLogGroup", "logs:DescribeLogStreams", "logs:CreateLogStream", "logs:PutLogEvents"]
        Resource = [
          "arn:${local.partition}:logs:${local.region}:${local.account}:log-group:/aws/bedrock-agentcore/runtimes/*",
          "arn:${local.partition}:logs:${local.region}:${local.account}:log-group:/aws/bedrock-agentcore/runtimes/*:log-stream:*",
        ]
      },
      {
        Sid      = "DescribeLogGroups"
        Effect   = "Allow"
        Action   = ["logs:DescribeLogGroups"]
        Resource = "arn:${local.partition}:logs:${local.region}:${local.account}:log-group:*"
      },
      {
        Sid      = "Tracing"
        Effect   = "Allow"
        Action   = ["xray:PutTraceSegments", "xray:PutTelemetryRecords", "xray:GetSamplingRules", "xray:GetSamplingTargets"]
        Resource = "*"
      },
      {
        Sid       = "Metrics"
        Effect    = "Allow"
        Action    = ["cloudwatch:PutMetricData"]
        Resource  = "*"
        Condition = { StringEquals = { "cloudwatch:namespace" = "bedrock-agentcore" } }
      },
      {
        Sid    = "WorkloadIdentity"
        Effect = "Allow"
        Action = [
          "bedrock-agentcore:GetWorkloadAccessToken",
          "bedrock-agentcore:GetWorkloadAccessTokenForJWT",
          "bedrock-agentcore:GetWorkloadAccessTokenForUserId",
        ]
        Resource = [
          "arn:${local.partition}:bedrock-agentcore:${local.region}:${local.account}:workload-identity-directory/default",
          "arn:${local.partition}:bedrock-agentcore:${local.region}:${local.account}:workload-identity-directory/default/workload-identity/${local.runtime_name}-*",
        ]
      },
      ], var.memory_arn == null ? [] : [{
        Sid    = "UseMemory"
        Effect = "Allow"
        Action = [
          "bedrock-agentcore:CreateEvent",
          "bedrock-agentcore:GetEvent",
          "bedrock-agentcore:ListEvents",
          "bedrock-agentcore:DeleteEvent",
          "bedrock-agentcore:ListSessions",
          "bedrock-agentcore:ListActors",
          "bedrock-agentcore:RetrieveMemoryRecords",
          "bedrock-agentcore:ListMemoryRecords",
          "bedrock-agentcore:GetMemoryRecord",
        ]
        Resource = [var.memory_arn]
    }])
  })
}

# A freshly created role is not assumable everywhere at once, and AgentCore
# rejects the runtime when it validates a role it cannot yet assume.
resource "time_sleep" "role_propagation" {
  create_duration = "30s"
  triggers = {
    role_arn = aws_iam_role.agent.arn
    policy   = aws_iam_role_policy.agent.policy
  }
}

resource "aws_bedrockagentcore_agent_runtime" "this" {
  agent_runtime_name    = local.runtime_name
  description           = "${var.project} agent (${var.environment}) on ${var.model_id}"
  role_arn              = time_sleep.role_propagation.triggers["role_arn"]
  environment_variables = local.env

  agent_runtime_artifact {
    container_configuration {
      container_uri = var.container_image
    }
  }

  network_configuration {
    network_mode = "PUBLIC"
  }

  protocol_configuration {
    server_protocol = var.server_protocol
  }

  tags = var.tags
}

resource "aws_bedrockagentcore_agent_runtime_endpoint" "this" {
  name             = local.endpoint_name
  agent_runtime_id = aws_bedrockagentcore_agent_runtime.this.agent_runtime_id
  description      = "Endpoint for ${var.project} (${var.environment})"
  tags             = var.tags
}
