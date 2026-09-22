output "memory_id" {
  description = "Passed to the agent so it can read and write its sessions."
  value       = aws_bedrockagentcore_memory.this.id
}

output "memory_arn" {
  description = "The memory, for scoping who may use it."
  value       = aws_bedrockagentcore_memory.this.arn
}
