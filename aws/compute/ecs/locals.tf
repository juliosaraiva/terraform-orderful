locals {
  user_data = []
  task_definitions = {
    app_name         = "test-app"
    app_image        = "public.ecr.aws/j3t8a0t2/devops-challenge:latest"
    log_group_name   = "/aws/ecs/devops-challenge"
    log_group_region = data.aws_region.current.name
  }
}
