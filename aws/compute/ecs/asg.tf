resource "aws_autoscaling_group" "orderful" {
  name                      = "${var.prefix}-ecs-cluster"
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  vpc_zone_identifier       = var.private_subnet_ids
  target_group_arns         = [aws_lb_target_group.orderful.arn]

  launch_template {
    id      = aws_launch_template.ecs_instance_template.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }

}
