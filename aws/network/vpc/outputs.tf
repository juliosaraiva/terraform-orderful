output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.orderful.id
}

output "vpc_arn" {
  description = "VPC ARN"
  value       = aws_vpc.orderful.arn
}

output "internet_gateway_id" {
  value = aws_internet_gateway.orderful.id
}

output "rtb_public_id" {
  value = aws_route_table.public.id
}

output "rtb_public_arn" {
  value = aws_route_table.public.arn
}
