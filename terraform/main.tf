# ============================================
# 7 Days DevOps Challenge - Main Configuration
# ============================================
# This file orchestrates all the modules for the complete CI/CD pipeline

# --------------------------------------------
# Day 1: Networking (VPC, Subnets, Security)
# --------------------------------------------
module "networking" {
  source = "./modules/networking"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

# --------------------------------------------
# Day 1: Compute (EC2 Instance)
# --------------------------------------------
module "compute" {
  source = "./modules/compute"

  project_name      = var.project_name
  environment       = var.environment
  instance_type     = var.instance_type
  subnet_id         = module.networking.public_subnet_id
  security_group_id = module.networking.security_group_id
  key_pair_name     = var.key_pair_name
  aws_region        = var.aws_region

  depends_on = [module.networking]
}

# --------------------------------------------
# Day 3: CodeArtifact (Dependency Storage)
# --------------------------------------------
module "codeartifact" {
  source = "./modules/codeartifact"

  project_name = var.project_name
  aws_region   = var.aws_region
}

# --------------------------------------------
# Day 4: CodeBuild (Continuous Integration)
# --------------------------------------------
module "codebuild" {
  source = "./modules/codebuild"

  project_name            = var.project_name
  codeartifact_domain     = module.codeartifact.domain_name
  codeartifact_repository = module.codeartifact.repository_name

  depends_on = [module.codeartifact]
}

# --------------------------------------------
# Day 5: CodeDeploy (Continuous Deployment)
# --------------------------------------------
module "codedeploy" {
  source = "./modules/codedeploy"

  project_name = var.project_name

  depends_on = [module.compute]
}

# --------------------------------------------
# Day 7: CodePipeline (Full CI/CD)
# --------------------------------------------
module "codepipeline" {
  source = "./modules/codepipeline"

  project_name                   = var.project_name
  github_repo_owner              = var.github_repo_owner
  github_repo_name               = var.github_repo_name
  github_branch                  = var.github_branch
  codebuild_project_name         = module.codebuild.project_name
  codebuild_project_arn          = module.codebuild.project_arn
  codebuild_artifacts_bucket_arn = module.codebuild.artifacts_bucket_arn
  codedeploy_app_name            = module.codedeploy.app_name
  codedeploy_deployment_group_name = module.codedeploy.deployment_group_name

  depends_on = [module.codebuild, module.codedeploy]
}
