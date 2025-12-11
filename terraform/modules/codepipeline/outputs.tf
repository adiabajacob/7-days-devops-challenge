output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.main.name
}

output "pipeline_arn" {
  description = "ARN of the CodePipeline"
  value       = aws_codepipeline.main.arn
}

output "connection_arn" {
  description = "ARN of the CodeStar connection"
  value       = aws_codestarconnections_connection.github.arn
}

output "connection_status" {
  description = "Status of the CodeStar connection"
  value       = aws_codestarconnections_connection.github.connection_status
}

output "artifacts_bucket_name" {
  description = "Name of the pipeline artifacts S3 bucket"
  value       = aws_s3_bucket.pipeline_artifacts.bucket
}
