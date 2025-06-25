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
