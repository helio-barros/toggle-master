module "networking" {
  source      = "./modules/networking"
  environment = var.environment
}

module "eks" {
  source             = "./modules/eks"
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
}

module "ecr" {
  source = "./modules/ecr"
}

module "rds" {
  source              = "./modules/rds"
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr_block
  private_subnet_ids  = module.networking.private_subnet_ids
}
module "cache" {
  source              = "./modules/cache"
  environment         = var.environment
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = module.networking.vpc_cidr_block
  private_subnet_ids  = module.networking.private_subnet_ids
}
