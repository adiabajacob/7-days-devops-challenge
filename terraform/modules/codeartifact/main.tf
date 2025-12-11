# ============================================
# Day 3: CodeArtifact - Dependency Storage
# ============================================

# Get current AWS account ID
data "aws_caller_identity" "current" {}

# CodeArtifact Domain
resource "aws_codeartifact_domain" "main" {
  domain = "${var.project_name}-domain"

  tags = {
    Name = "${var.project_name}-codeartifact-domain"
  }
}

# External npm public repository connection
resource "aws_codeartifact_repository" "npm_store" {
  repository = "npm-store"
  domain     = aws_codeartifact_domain.main.domain

  external_connections {
    external_connection_name = "public:npmjs"
  }

  tags = {
    Name = "${var.project_name}-npm-store"
  }
}

# Internal repository for project packages
resource "aws_codeartifact_repository" "main" {
  repository = "${var.project_name}-repo"
  domain     = aws_codeartifact_domain.main.domain

  upstream {
    repository_name = aws_codeartifact_repository.npm_store.repository
  }

  tags = {
    Name = "${var.project_name}-codeartifact-repo"
  }
}

# Domain policy to allow CodeBuild access
resource "aws_codeartifact_domain_permissions_policy" "main" {
  domain = aws_codeartifact_domain.main.domain

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCodeBuild"
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = [
          "codeartifact:GetAuthorizationToken",
          "codeartifact:GetRepositoryEndpoint",
          "codeartifact:ReadFromRepository"
        ]
        Resource = "*"
      }
    ]
  })
}
