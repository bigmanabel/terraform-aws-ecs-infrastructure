module "ecs_fargate" {
  source             = "./modules/ecs-fargate"
  aws_region         = var.aws_region
  project_name       = var.project_name
  domain_name        = var.domain_name
  image_url          = var.image_url
  vpc_id             = var.vpc_id
  public_subnet_ids  = var.public_subnet_ids
  private_subnet_ids = var.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  github_repo_url    = var.github_repo_url
  artifact_bucket    = var.artifact_bucket
  github_owner       = var.github_owner
  github_repo        = var.github_repo
  github_branch      = var.github_branch
}
