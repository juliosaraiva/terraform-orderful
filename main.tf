module "vpc" {
  source     = "./aws/network/vpc"
  version    = "0.0.1"
  cidr_block = "10.16.0.0/16"
}

module "subnet-us-east-1a" {
  source              = "./aws/network/subnets"
  version             = "0.0.1"
  private_subnet_cidr = "10.16.16.0/20"
  public_subnet_cidr  = "10.16.112.0/20"
  availability_zone   = "us-east-1a"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  rtb_public_id       = module.vpc.rtb_public_id
}

module "subnet-us-east-1b" {
  source              = "./aws/network/subnets"
  version             = "0.0.1"
  private_subnet_cidr = "10.16.32.0/20"
  public_subnet_cidr  = "10.16.128.0/20"
  availability_zone   = "us-east-1b"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  rtb_public_id       = module.vpc.rtb_public_id
}

module "ecs" {
  source             = "./aws/compute/ecs"
  version            = "0.0.1"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids
  ssh_public_key     = var.ssh_public_key
}
