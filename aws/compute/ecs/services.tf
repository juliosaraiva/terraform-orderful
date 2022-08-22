resource "aws_ecs_task_definition" "test-app" {
  family                   = local.task_definitions.app_name
  container_definitions    = templatefile("${path.module}/templates/container-definitions.json.tpl", local.task_definitions)
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = aws_iam_role.ecs_service.arn
  task_role_arn            = aws_iam_role.ecs_task.arn
}

resource "aws_ecs_service" "test-app" {
  name            = "${var.prefix}-test-app"
  cluster         = aws_ecs_cluster.orderful.name
  task_definition = aws_ecs_task_definition.test-app.family
  desired_count   = 4

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orderful.arn
    container_name   = local.task_definitions.app_name
    container_port   = var.container_port
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_cluster.name
    base              = 1
    weight            = 1
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [
    aws_autoscaling_group.orderful,
    aws_lb_target_group.orderful
  ]
}

resource "aws_ecs_cluster_capacity_providers" "orderful" {
  cluster_name = aws_ecs_cluster.orderful.name

  capacity_providers = [aws_ecs_capacity_provider.ecs_cluster.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_cluster.name
  }
}

resource "aws_ecs_capacity_provider" "ecs_cluster" {
  name = "${var.prefix}-ecs-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.orderful.arn
  }
}
