resource "aws_vpc" "orderful" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_internet_gateway" "orderful" {
  vpc_id = aws_vpc.orderful.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.orderful.id

  tags = {
    Name = "${var.prefix}-rtb-public"
  }
}

data "aws_region" "current" {}
