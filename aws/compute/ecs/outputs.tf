output "cluster_name" {
  description = "ECS Cluster Name"
  value       = aws_ecs_cluster.orderful.name
}

output "cluster_id" {
  description = "ECS Cluster ID"
  value       = aws_ecs_cluster.orderful.id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.orderful.arn
}

output "cloudfront_endpoint_url" {
  description = "Cloudfront endpoint URL"
  value       = aws_cloudfront_distribution.orderful.domain_name
}
