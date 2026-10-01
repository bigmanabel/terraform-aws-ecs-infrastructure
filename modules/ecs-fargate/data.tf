# Data sources for the ECS Fargate module

# Get current AWS region
data "aws_region" "current" {}

# Get current AWS caller identity (account ID)
data "aws_caller_identity" "current" {}
