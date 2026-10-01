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
  description = "Deprecated compatibility input. It is ignored because RDS now manages the master password in Secrets Manager; remove it from local tfvars files."
  type        = string
  sensitive   = true
  default     = null
}

variable "deletion_protection" {
  description = "Prevent accidental deletion of the RDS instance. Disable explicitly before an intentional destroy."
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Skip the final RDS snapshot during destroy. Keep false for protected environments."
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "Optional final snapshot name used when skip_final_snapshot is false."
  type        = string
  default     = null
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
  description = "List of availability zones (if not provided, will use first 2 AZs in current region)"
  type        = list(string)
  default     = []
}
