output "repository_url" {
  description = "Push agent images here."
  value       = aws_ecr_repository.this.repository_url
}

output "repository_arn" {
  description = "The repository, for scoping who may pull from it."
  value       = aws_ecr_repository.this.arn
}

output "repository_name" {
  description = "The repository's name."
  value       = aws_ecr_repository.this.name
}
