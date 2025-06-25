# Data sources for the ECS Fargate module

# Get current AWS region
data "aws_region" "current" {}

# Get current AWS caller identity (account ID)
data "aws_caller_identity" "current" {}

# Get latest PostgreSQL engine version for the specified major version
data "aws_rds_engine_version" "postgresql" {
  engine             = "postgres"
  preferred_versions = ["15.8", "15.7", "15.6", "15.5", "15.4"]
}

# Get latest available AMI for ECS-optimized instances (if needed for future use)
data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
