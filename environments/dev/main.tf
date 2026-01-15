
module "vpc" {
  source      = "./modules/vpc"
  environment = var.environment
  vpc_cidr    = var.vpc_cidr
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
}

module "ec2" {
  source                = "./modules/ec2"
  environment           = var.environment
  key_name              = var.key_name
  public_subnet_id      = module.vpc.public_subnet_ids[0]
  private_subnet_id     = module.vpc.private_subnet_ids[0]
  public_instance_count  = 1
  private_instance_count = 2
}
