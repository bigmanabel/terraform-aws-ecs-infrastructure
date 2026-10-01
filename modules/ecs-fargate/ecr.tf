# ECR Repository for storing Docker images
resource "aws_ecr_repository" "nestjs" {
  name                 = "${var.project_name}-repo"
  force_delete         = false
  image_tag_mutability = "IMMUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name    = "${var.project_name}-ecr-repo"
    Project = var.project_name
  }
}

resource "aws_ecr_lifecycle_policy" "nestjs" {
  repository = aws_ecr_repository.nestjs.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Retain the 30 most recent images",
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 30
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
