module "vpc" {
  source       = "./modules/vpc"
  region       = var.aws_region
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  azs          = length(var.azs) > 0 ? var.azs : slice(data.aws_availability_zones.available.names, 0, 2)
}

module "ecs_fargate" {
  source                    = "./modules/ecs-fargate"
  project_name              = var.project_name
  image_url                 = var.image_url
  vpc_id                    = module.vpc.vpc_id
  public_subnet_ids         = module.vpc.public_subnet_ids
  private_subnet_ids        = module.vpc.private_subnet_ids
  db_username               = var.db_username
  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.final_snapshot_identifier
  github_owner              = var.github_owner
  github_repo               = var.github_repo
  github_branch             = var.github_branch
}
