resource "aws_subnet" "private" {
  cidr_block        = var.private_subnet_cidr
  vpc_id            = var.vpc_id
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.prefix}-subnet-private-${var.availability_zone}"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.prefix}-rtb-private-${var.availability_zone}"
  }
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.public.id
  destination_cidr_block = "0.0.0.0/0"
}
