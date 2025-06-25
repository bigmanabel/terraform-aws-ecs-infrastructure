# ECR Repository for storing Docker images
resource "aws_ecr_repository" "nestjs" {
  name = "${var.project_name}-repo"
}
