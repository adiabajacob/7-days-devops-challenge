# 7 Days DevOps Challenge 🚀
## Complete CI/CD Pipeline with Terraform & Node.js

This project recreates the [NextWork 7 Days DevOps Challenge](https://learn.nextwork.org/projects/aws-devops-challenge) using **Terraform** for infrastructure provisioning and a **Node.js** application instead of the original Java/Maven approach.

![Architecture](https://img.shields.io/badge/AWS-CI%2FCD%20Pipeline-orange?style=for-the-badge&logo=amazon-aws)
![Terraform](https://img.shields.io/badge/IaC-Terraform-purple?style=for-the-badge&logo=terraform)
![Node.js](https://img.shields.io/badge/Runtime-Node.js%2018-green?style=for-the-badge&logo=node.js)

---

## 📋 Table of Contents

- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Day-by-Day Breakdown](#day-by-day-breakdown)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Verification](#verification)
- [Cleanup](#cleanup)
- [Troubleshooting](#troubleshooting)

---

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                              AWS CI/CD Pipeline                          │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────┐    ┌──────────────┐    ┌───────────┐    ┌──────────────┐  │
│  │  GitHub  │───▶│ CodePipeline │───▶│ CodeBuild │───▶│  CodeDeploy  │  │
│  │   Repo   │    │   (Day 7)    │    │  (Day 4)  │    │   (Day 5)    │  │
│  └──────────┘    └──────────────┘    └─────┬─────┘    └──────┬───────┘  │
│                                            │                  │          │
│                                            ▼                  ▼          │
│                                     ┌─────────────┐   ┌──────────────┐  │
│                                     │CodeArtifact │   │     EC2      │  │
│                                     │  (Day 3)    │   │   (Day 1)    │  │
│                                     └─────────────┘   └──────────────┘  │
│                                                              │          │
│                             ┌────────────────────────────────┘          │
│                             ▼                                            │
│                    ┌─────────────────┐                                  │
│                    │  VPC + Subnet   │                                  │
│                    │    (Day 1)      │                                  │
│                    └─────────────────┘                                  │
│                                                                          │
│                    ┌─────────────────────────────────────────────────┐  │
│                    │           Terraform (Day 6)                      │  │
│                    │   All infrastructure defined as code             │  │
│                    └─────────────────────────────────────────────────┘  │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## ✅ Prerequisites

Before you begin, ensure you have the following installed:

| Tool | Version | Installation |
|------|---------|--------------|
| **Terraform** | >= 1.0.0 | [Install Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) |
| **AWS CLI** | v2 | [Install Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) |
| **Node.js** | 18.x | [Install Guide](https://nodejs.org/) |
| **Git** | Latest | [Install Guide](https://git-scm.com/) |

### AWS Configuration

Configure your AWS credentials:

```bash
aws configure
```

Required permissions:
- EC2, VPC
- IAM (create roles/policies)
- S3
- CodeBuild, CodeDeploy, CodePipeline
- CodeArtifact
- CodeStar Connections

---

## 🚀 Quick Start

### Step 1: Clone and Configure

```bash
cd "7 days devops challenge"

# Edit terraform.tfvars with your settings
cd terraform
nano terraform.tfvars
```

Update these values in `terraform.tfvars`:
```hcl
github_repo_owner = "YOUR_GITHUB_USERNAME"
github_repo_name  = "7-days-devops-challenge"
```

### Step 2: Initialize and Apply Terraform

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply
```

### Step 3: Approve CodeStar Connection

After `terraform apply`, you MUST manually approve the GitHub connection:

1. Go to **AWS Console** → **Developer Tools** → **Settings** → **Connections**
2. Find the connection named `devops-challenge-github-connection`
3. Click **Update pending connection**
4. Authorize access to your GitHub account

### Step 4: Push Code to GitHub

```bash
cd ..  # Back to project root

# Initialize Git repository
git init
git add .
git commit -m "Initial commit - 7 Days DevOps Challenge"

# Create GitHub repository and push
# (Create repo on GitHub first, then:)
git remote add origin https://github.com/YOUR_USERNAME/7-days-devops-challenge.git
git branch -M main
git push -u origin main
```

### Step 5: Watch the Magic! ✨

Once you push to GitHub, the pipeline will automatically:
1. **Pull** the source code
2. **Build** with CodeBuild
3. **Deploy** to EC2 with CodeDeploy

Access your application at the URL shown in Terraform outputs:
```bash
terraform output application_url
```

---

## 📅 Day-by-Day Breakdown

### Day 1: EC2 Web Server + Networking
- VPC with public subnet
- Internet Gateway and Route Table
- Security Group (ports 80, 443, 3000, 22)
- EC2 instance with Amazon Linux 2023
- Node.js and CodeDeploy agent installed via user data

### Day 2: GitHub Integration
- CodeStar connection for GitHub
- Repository structure and source code

### Day 3: CodeArtifact (Dependencies)
- CodeArtifact domain
- npm repository connected to public npmjs
- Internal project repository with upstream

### Day 4: CodeBuild (CI)
- CodeBuild project for Node.js 18
- S3 bucket for build artifacts
- buildspec.yml for build configuration

### Day 5: CodeDeploy (CD)
- CodeDeploy application
- Deployment group targeting EC2 by tags
- appspec.yml with lifecycle hooks
- Deployment scripts (stop, install, start, validate)

### Day 6: Infrastructure as Code
- Everything is Terraform! 🎉
- Modular structure
- Variables for customization
- Comprehensive outputs

### Day 7: CodePipeline
- 3-stage pipeline: Source → Build → Deploy
- Automatic triggering on git push
- S3 artifact store

---

## 📁 Project Structure

```
7 days devops challenge/
├── README.md                 # This file
├── app/                      # Node.js Application (Day 1)
│   ├── package.json
│   ├── server.js
│   └── public/
│       └── index.html
├── scripts/                  # CodeDeploy Scripts (Day 5)
│   ├── install_dependencies.sh
│   ├── start_server.sh
│   ├── stop_server.sh
│   └── validate_service.sh
├── buildspec.yml             # CodeBuild config (Day 4)
├── appspec.yml               # CodeDeploy config (Day 5)
└── terraform/                # Infrastructure (Day 6)
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── providers.tf
    ├── terraform.tfvars
    └── modules/
        ├── networking/       # Day 1
        ├── compute/          # Day 1
        ├── codeartifact/     # Day 3
        ├── codebuild/        # Day 4
        ├── codedeploy/       # Day 5
        └── codepipeline/     # Day 7
```

---

## ⚙️ Configuration

### terraform.tfvars Options

| Variable | Description | Default |
|----------|-------------|---------|
| `aws_region` | AWS region | `us-east-1` |
| `project_name` | Project name for resources | `devops-challenge` |
| `environment` | Environment tag | `dev` |
| `instance_type` | EC2 instance type | `t2.micro` |
| `github_repo_owner` | GitHub username | **Required** |
| `github_repo_name` | Repository name | **Required** |
| `github_branch` | Branch to track | `main` |
| `key_pair_name` | EC2 key pair for SSH | `""` (optional) |

---

## ✅ Verification

### Check EC2 Instance
```bash
# Get public IP
terraform output ec2_public_ip

# Test the application
curl http://$(terraform output -raw ec2_public_ip):3000/health
```

### Check Pipeline Status
```bash
# View pipeline in AWS Console
aws codepipeline get-pipeline-state --name devops-challenge-pipeline
```

### Application Endpoints
- **Main Page**: `http://<EC2_IP>:3000/`
- **Health Check**: `http://<EC2_IP>:3000/health`
- **API Info**: `http://<EC2_IP>:3000/api/info`

---

## 🧹 Cleanup

To destroy all AWS resources and avoid charges:

```bash
cd terraform
terraform destroy
```

> ⚠️ This will permanently delete all resources. Make sure you've saved any important data!

---

## 🐛 Troubleshooting

### CodeDeploy Fails
```bash
# Check CodeDeploy agent on EC2
sudo systemctl status codedeploy-agent

# View deployment logs
cat /var/log/aws/codedeploy-agent/codedeploy-agent.log
```

### Pipeline Stuck at Source
- Ensure the CodeStar connection is in `AVAILABLE` status
- Check that you authorized GitHub access

### Application Not Accessible
```bash
# Check if app is running
ps aux | grep node

# Check application logs
cat /var/log/devops-app.log

# Verify security group allows port 3000
```

### Terraform State Issues
```bash
# Refresh state
terraform refresh

# Import existing resources if needed
terraform import <resource_type>.<name> <resource_id>
```

---

## 📚 Resources

- [NextWork 7 Days DevOps Challenge](https://learn.nextwork.org/projects/aws-devops-challenge)
- [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS CodePipeline Documentation](https://docs.aws.amazon.com/codepipeline/)
- [AWS CodeBuild Documentation](https://docs.aws.amazon.com/codebuild/)
- [AWS CodeDeploy Documentation](https://docs.aws.amazon.com/codedeploy/)

---

## 📄 License

MIT License - feel free to use this for learning and portfolio purposes!

---

**Built with ❤️ for the DevOps community**
