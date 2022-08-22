output "endpoint_url" {
  description = "Cloudfront Endpoint to access the application."
  value       = "${module.ecs.cloudfront_endpoint_url}/api/health/check"
}
