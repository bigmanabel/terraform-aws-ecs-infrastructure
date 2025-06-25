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

variable "image_url" {
  description = "The URL of the Docker image to deploy"
  type        = string
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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
