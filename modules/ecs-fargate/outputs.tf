output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "rds_endpoint" {
  value = aws_db_instance.postgres.endpoint
}

output "rds_port" {
  value = aws_db_instance.postgres.port
}

output "rds_secret_arn" {
  value = aws_secretsmanager_secret.db_credentials.arn
}

output "artifacts_bucket_name" {
  description = "Name of the S3 bucket for CodePipeline artifacts"
  value       = aws_s3_bucket.artifacts.bucket
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.nestjs.repository_url
}
