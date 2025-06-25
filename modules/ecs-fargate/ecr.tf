# ECR Repository for storing Docker images
resource "aws_ecr_repository" "nestjs" {
  name                 = "${var.project_name}-repo"
  force_delete         = true
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project_name}-ecr-repo"
    Project = var.project_name
  }
}
