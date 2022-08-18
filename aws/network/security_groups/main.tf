resource "aws_security_group" "allow-http" {
  name        = "allow-http-from-anywhere"
  description = "Allow HTTP requests from Anywhere."
  vpc_id      = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "allow-ecs" {
  description = "Access for the ECS Service"
  name        = "Allow Connections to ECS"
  vpc_id      = var.vpc_id

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol        = "-1"
    from_port       = 0
    to_port         = 0
    security_groups = [aws_security_group.allow-http.id]
  }
}
