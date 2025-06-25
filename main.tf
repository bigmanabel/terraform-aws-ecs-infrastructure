module "vpc" {
  source       = "./modules/vpc"
  region       = var.aws_region
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
}

module "ecs_fargate" {
  source             = "./modules/ecs-fargate"
  aws_region         = var.aws_region
  project_name       = var.project_name
  domain_name        = var.domain_name
  image_url          = var.image_url
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  db_username        = var.db_username
  db_password        = var.db_password
  github_owner       = var.github_owner
  github_repo        = var.github_repo
  github_branch      = var.github_branch
}
