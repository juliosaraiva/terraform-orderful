output "instance_role" {
  value = aws_iam_role.instance_role.arn
}

output "launch_template_id" {
  value = aws_launch_template.ecs_instance_template.id
}
