# Terraform AWS ECS Infrastructure

Infrastructure as code for deploying a containerized NestJS app on AWS using ECS
Fargate, ALB, RDS, and CloudWatch. Includes modules for VPC, IAM, and CI/CD
integration via CodePipeline.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- A VPC with public and private subnets
- An S3 bucket for CodePipeline artifacts
- A GitHub repository with your application code
- A GitHub OAuth token

## Setup Instructions

1. **Configure Variables**: Update the `terraform.tfvars` file with your
   specific values:

```hcl
# Basic Configuration
aws_region   = "us-east-1"
project_name = "your-project-name"
domain_name  = "api.yourdomain.com"
image_url    = "your-account.dkr.ecr.us-east-1.amazonaws.com/your-app:latest"

# VPC and Subnet Configuration
vpc_id             = "vpc-xxxxxxxxx"
public_subnet_ids  = ["subnet-xxxxxxxxx", "subnet-yyyyyyyyy"]
private_subnet_ids = ["subnet-zzzzzzzzz", "subnet-aaaaaaaaa"]

# Database Configuration
db_username = "postgres"
db_password = "your-secure-password"

# GitHub Configuration
github_repo_url    = "https://github.com/your-username/your-repo.git"
artifact_bucket    = "your-artifact-bucket-name"
github_owner       = "your-username"
github_repo        = "your-repo"
github_branch      = "main"
github_oauth_token = "your-github-oauth-token"
```

2. **Initialize Terraform**:

```bash
terraform init
```

3. **Validate Configuration**:

```bash
terraform validate
```

4. **Plan Deployment**:

```bash
terraform plan
```

5. **Deploy Infrastructure**:

```bash
terraform apply
```

## What This Creates

- **ECS Cluster**: Fargate-based cluster for running containerized applications
- **Application Load Balancer**: For distributing traffic to ECS tasks
- **RDS PostgreSQL**: Database instance with automatic backups
- **ECR Repository**: For storing Docker images
- **CodePipeline & CodeBuild**: CI/CD pipeline connected to GitHub
- **IAM Roles & Policies**: Proper permissions for all services
- **Security Groups**: Network security rules
- **Secrets Manager**: Secure storage for database credentials
- **CloudWatch**: Logging and monitoring

## Outputs

After deployment, you'll get:

- `alb_dns_name`: The DNS name of your load balancer
- `ecs_service_name`: Name of the ECS service
- `cluster_name`: Name of the ECS cluster
- `rds_endpoint`: Database endpoint
- `rds_port`: Database port

## Security Notes

- Database is deployed in private subnets
- RDS instance is not publicly accessible
- Secrets are stored in AWS Secrets Manager
- Security groups follow least privilege principles

## Clean Up

To destroy all resources:

```bash
terraform destroy
```

**Warning**: This will delete all resources including the database. Make sure to
backup any important data first.
