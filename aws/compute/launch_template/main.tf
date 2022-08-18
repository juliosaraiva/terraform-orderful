data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
}

resource "aws_key_pair" "key" {
  key_name   = "deployer"
  public_key = var.ssh_public_key
}

resource "aws_launch_template" "ecs_instance_template" {
  name_prefix            = "ecs_node_"
  image_id               = data.aws_ami.ecs.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.key_name
  user_data              = var.user_data != null ? base64encode(var.user_data) : data.cloudinit_config.config.rendered
  vpc_security_group_ids = var.ecs_security_groups

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_node.name
  }

  monitoring {
    enabled = true
  }
}
