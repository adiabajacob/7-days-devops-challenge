output "domain_name" {
  description = "Name of the CodeArtifact domain"
  value       = aws_codeartifact_domain.main.domain
}

output "domain_arn" {
  description = "ARN of the CodeArtifact domain"
  value       = aws_codeartifact_domain.main.arn
}

output "repository_name" {
  description = "Name of the CodeArtifact repository"
  value       = aws_codeartifact_repository.main.repository
}

output "repository_arn" {
  description = "ARN of the CodeArtifact repository"
  value       = aws_codeartifact_repository.main.arn
}

output "repository_endpoint" {
  description = "Repository endpoint URL for npm"
  value       = "https://${aws_codeartifact_domain.main.domain}-${data.aws_caller_identity.current.account_id}.d.codeartifact.${var.aws_region}.amazonaws.com/npm/${aws_codeartifact_repository.main.repository}/"
}

output "npm_login_command" {
  description = "Command to login npm to CodeArtifact"
  value       = "aws codeartifact login --tool npm --repository ${aws_codeartifact_repository.main.repository} --domain ${aws_codeartifact_domain.main.domain} --domain-owner ${data.aws_caller_identity.current.account_id} --region ${var.aws_region}"
}
