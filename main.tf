module "vpc" {
  source     = "./aws/network/vpc"
  cidr_block = "10.16.0.0/16"
}

module "subnet-us-east-1a" {
  source              = "./aws/network/subnets"
  private_subnet_cidr = "10.16.16.0/20"
  public_subnet_cidr  = "10.16.112.0/20"
  availability_zone   = "us-east-1a"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  rtb_public_id       = module.vpc.rtb_public_id
}

module "subnet-us-east-1b" {
  source              = "./aws/network/subnets"
  private_subnet_cidr = "10.16.32.0/20"
  public_subnet_cidr  = "10.16.128.0/20"
  availability_zone   = "us-east-1b"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.vpc.internet_gateway_id
  rtb_public_id       = module.vpc.rtb_public_id
}

module "security_groups" {
  source = "./aws/network/security_groups"

  vpc_id = module.vpc.vpc_id
}

module "launch_template" {
  source              = "./aws/compute/launch_template"
  ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDQlORKUOuEpu0EbqSEMWXqiAwR4lksJf9gvNhWToxVEf5s8uhBe8B63UjKprHuCdERz7Noh6nuyVTVC+h7E/HDKft9EJsQ9VK+BEjfNG4WR1FrxrrureqoFz+y9w2tzmU4gp+kNDT1DiLlJwsNeUlvjrXVwVy4LCAba6oUdcajyDBOu4jIPXtA3VihXp6icw5/9OEHaX+p5Qi1lspAJ98cigRPO1dnsoUjYzoNshBR0n/3Me060Z4Liwk7P/4/jrIax1wPuGleWf6hAsjoHtM9vixeWVIleWX4df29+ueuKKw74/Egy7YylFscH6oJ4LZbuNeSDFuKFRTf/7zs2785"
  vpc_id              = module.vpc.vpc_id
  ecs_security_groups = [module.security_groups.ecs_security_group_id]
  private_subnet_ids  = [module.subnet-us-east-1a.private_subnet_id, module.subnet-us-east-1b.private_subnet_id]
}

module "ecs" {
  source = "./aws/compute/ecs"

  vpc_id             = module.vpc.vpc_id
  security_group_id  = module.security_groups.http_security_group_id
  public_subnet_ids  = [module.subnet-us-east-1a.public_subnet_id, module.subnet-us-east-1b.public_subnet_id]
  private_subnet_ids = [module.subnet-us-east-1a.private_subnet_id, module.subnet-us-east-1b.private_subnet_id]
  ecs_security_group = [module.security_groups.ecs_security_group_id]
  execution_role_arn = module.launch_template.instance_role
  launch_template_id = module.launch_template.launch_template_id
}
