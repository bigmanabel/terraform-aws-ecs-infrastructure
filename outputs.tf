output "alb_dns_name" {
  value = module.ecs_fargate.alb_dns_name
}

output "ecs_service_name" {
  value = module.ecs_fargate.service_name
}

output "task_definition_arn" {
  value = module.ecs_fargate.task_definition_arn
}

output "cluster_name" {
  value = module.ecs_fargate.cluster_name
}

output "rds_endpoint" {
  value = module.ecs_fargate.rds_endpoint
}

output "rds_port" {
  value = module.ecs_fargate.rds_port
}

// VPC outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "artifacts_bucket_name" {
  description = "Name of the automatically generated S3 bucket for CodePipeline artifacts"
  value       = module.ecs_fargate.artifacts_bucket_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository for Docker images"
  value       = module.ecs_fargate.ecr_repository_url
}
