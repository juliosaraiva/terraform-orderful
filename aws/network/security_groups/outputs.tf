output "http_security_group_id" {
  description = "HTTP Security Group ID"
  value       = aws_security_group.allow-http.id
}

output "ecs_security_group_id" {
  description = "ECS Security Group ID"
  value       = aws_security_group.allow-ecs.id
}
