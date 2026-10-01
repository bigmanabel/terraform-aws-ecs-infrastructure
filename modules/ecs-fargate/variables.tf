variable "project_name" {
  type = string
}

variable "image_url" {
  type        = string
  description = "ECR image URI for the app container"
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

variable "deletion_protection" {
  type        = bool
  description = "Prevent accidental deletion of the RDS instance."
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip the final RDS snapshot during destroy."
}

variable "final_snapshot_identifier" {
  type        = string
  description = "Optional final snapshot name used when skip_final_snapshot is false."
  default     = null
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
