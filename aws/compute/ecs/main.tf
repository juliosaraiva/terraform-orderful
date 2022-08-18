resource "aws_ecs_cluster" "orderful" {
  name = "${var.prefix}-cluster"

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights == "yes" ? "enabled" : "disabled"
  }
}

resource "aws_cloudwatch_log_group" "ecs_tasks_logs" {
  name = local.task_definitions.log_group_name
}
