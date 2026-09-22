# Conversation memory for an AgentCore agent: events a session writes survive
# the session, so a returning user is not a stranger.

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18"
    }
  }
}

locals {
  # AgentCore names allow letters, digits and underscores only.
  name = substr(replace("${var.project}_memory_${var.environment}", "/[^a-zA-Z0-9_]/", "_"), 0, 48)
}

resource "aws_bedrockagentcore_memory" "this" {
  name                  = local.name
  description           = "Conversation memory for ${var.project} (${var.environment})"
  event_expiry_duration = var.event_expiry_days
  encryption_key_arn    = var.kms_key_arn
  tags                  = var.tags
}
