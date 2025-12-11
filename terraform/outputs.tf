output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = module.compute.public_dns
}

output "application_url" {
  description = "URL to access the application"
  value       = "http://${module.compute.public_ip}:3000"
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "codeartifact_repository_url" {
  description = "CodeArtifact repository URL"
  value       = module.codeartifact.repository_endpoint
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = module.codebuild.project_name
}

output "codedeploy_app_name" {
  description = "Name of the CodeDeploy application"
  value       = module.codedeploy.app_name
}

output "codepipeline_name" {
  description = "Name of the CodePipeline"
  value       = module.codepipeline.pipeline_name
}

output "codestar_connection_arn" {
  description = "ARN of the CodeStar connection (needs manual approval in AWS Console)"
  value       = module.codepipeline.connection_arn
}

output "important_next_steps" {
  description = "Steps to complete after terraform apply"
  value       = <<-EOT
    
    ========================================
    IMPORTANT: Complete these steps manually
    ========================================
    
    1. APPROVE CODESTAR CONNECTION:
       Go to AWS Console → Developer Tools → Settings → Connections
       Find the connection and click "Update pending connection"
       Authorize access to your GitHub account
    
    2. PUSH CODE TO GITHUB:
       git init
       git add .
       git commit -m "Initial commit"
       git remote add origin https://github.com/${var.github_repo_owner}/${var.github_repo_name}.git
       git push -u origin main
    
    3. ACCESS YOUR APPLICATION:
       http://${module.compute.public_ip}:3000
    
    ========================================
  EOT
}
