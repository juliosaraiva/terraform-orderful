resource "aws_lb" "orderful" {
  name               = "orderful-alb-app"
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [var.security_group_id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "orderful" {
  load_balancer_arn = aws_lb.orderful.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orderful.arn
  }
}

resource "aws_lb_target_group" "orderful" {
  name        = "orderful-ecs-app"
  vpc_id      = var.vpc_id
  port        = 4545
  protocol    = "HTTP"
  target_type = var.target_type

  health_check {
    path                = var.target_group_health_check.path
    protocol            = var.target_group_health_check.protocol
    healthy_threshold   = var.target_group_health_check.healthy_threshold
    unhealthy_threshold = var.target_group_health_check.unhealthy_threshold
    interval            = var.target_group_health_check.interval
  }
}

