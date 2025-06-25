variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "tf-aws-ecs-fargate"
}

variable "domain_name" {
  description = "The domain name for the application"
  type        = string
  default     = "example.com"
}

variable "image_url" {
  description = "The URL of the Docker image to deploy"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to deploy resources into"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ECS & RDS"
  type        = list(string)
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "github_repo_url" {
  description = "GitHub repository URL for the application source code"
  type        = string
}

variable "artifact_bucket" {
  description = "S3 bucket name for storing build artifacts"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner (username or organization)"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to use for the CodePipeline"
  type        = string
  default     = "main"
}

variable "github_oauth_token" {
  description = "GitHub OAuth token for accessing the repository"
  type        = string
  sensitive   = true
}
