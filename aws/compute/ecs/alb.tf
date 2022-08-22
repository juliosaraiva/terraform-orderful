resource "aws_lb" "orderful" {
  name               = "${var.prefix}-lb-test-app"
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.allow-http.id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "orderful" {
  load_balancer_arn = aws_lb.orderful.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      status_code  = "403"
      message_body = "<h1>Access Denied</h1>"
    }
  }
}

resource "aws_lb_listener_rule" "orderful-listener-rule" {
  listener_arn = aws_lb_listener.orderful.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orderful.arn
  }

  condition {
    http_header {
      http_header_name = "X-Orderful-Origin"
      values           = ["68e109f0f40ca72a15e05cc22786f8e6"]
    }
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

