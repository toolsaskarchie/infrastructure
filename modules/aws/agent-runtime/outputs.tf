output "agent_runtime_id" {
  description = "The runtime's id."
  value       = aws_bedrockagentcore_agent_runtime.this.agent_runtime_id
}

output "agent_runtime_arn" {
  description = "What callers pass to InvokeAgentRuntime."
  value       = aws_bedrockagentcore_agent_runtime.this.agent_runtime_arn
}

output "endpoint_name" {
  description = "The qualifier callers pass to reach this endpoint."
  value       = aws_bedrockagentcore_agent_runtime_endpoint.this.name
}

output "endpoint_arn" {
  description = "The named endpoint."
  value       = aws_bedrockagentcore_agent_runtime_endpoint.this.agent_runtime_endpoint_arn
}

output "role_arn" {
  description = "The role the agent runs as."
  value       = aws_iam_role.agent.arn
}
