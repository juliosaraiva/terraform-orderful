resource "aws_ecs_task_definition" "app" {
  family                   = local.task_definitions.app_name
  container_definitions    = templatefile("${path.module}/templates/container-definitions.json.tpl", local.task_definitions)
  requires_compatibilities = var.requires_compatibilities
  network_mode             = var.network_mode
  execution_role_arn       = aws_iam_role.ecs_service_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
}

resource "aws_ecs_service" "app" {
  name            = "${var.prefix}-devops-challenge"
  cluster         = aws_ecs_cluster.orderful.name
  task_definition = aws_ecs_task_definition.app.family
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
    aws_autoscaling_group.cluster,
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
    auto_scaling_group_arn = aws_autoscaling_group.cluster.arn
  }
}

resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 8
  min_capacity       = 4
  resource_id        = "service/${aws_ecs_cluster.orderful.name}/${aws_ecs_service.app.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "CPUTaskAutoScaling" {
  name               = "ecs-task-cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 80
  }

  depends_on = [
    aws_appautoscaling_target.ecs_target
  ]
}

resource "aws_appautoscaling_policy" "MemoryTaskAutoScaling" {
  name               = "ecs-task-memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
    target_value = 80
  }

  depends_on = [
    aws_appautoscaling_target.ecs_target
  ]
}
