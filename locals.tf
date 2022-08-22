data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  private_subnet_ids = [module.subnet-us-east-1a.private_subnet_id, module.subnet-us-east-1b.private_subnet_id]
  public_subnet_ids  = [module.subnet-us-east-1a.public_subnet_id, module.subnet-us-east-1b.public_subnet_id]
}
