resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 8
  min_capacity       = 4
  resource_id        = "service/${aws_ecs_cluster.orderful.name}/${aws_ecs_service.test-app.name}"
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
