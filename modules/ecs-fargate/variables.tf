variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "image_url" {
  type        = string
  description = "ECR image URI for the app container"
}

variable "domain_name" {
  type        = string
  description = "Optional custom domain for the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to deploy resources into"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for ALB"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for ECS & RDS"
}

variable "db_username" {
  type        = string
  description = "Master username for the RDS instance"
  default     = "postgres"
}

variable "db_password" {
  type        = string
  description = "Master password for the RDS instance"
  sensitive   = true
}

variable "github_repo_url" {
  type        = string
  description = "GitHub repository URL for the application source code"
}

variable "artifact_bucket" {
  type        = string
  description = "S3 bucket name for storing build artifacts"

}

variable "github_owner" {
  type        = string
  description = "GitHub owner (username or organization)"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository name"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch to use for the CodePipeline"
}

variable "github_oauth_token" {
  type        = string
  description = "GitHub OAuth token for accessing the repository"
  sensitive   = true
}
