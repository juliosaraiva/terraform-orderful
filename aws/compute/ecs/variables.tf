// Required
variable "private_subnet_ids" {
  description = "List of private subnets for ECS"
  type        = list(string)
}
variable "public_subnet_ids" {
  description = "List of public subnets for ALB"
  type        = list(string)
}
variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
// Required

variable "container_port" {
  description = "Container Port to Listening On"
  type        = number
  default     = 4545
}
variable "enable_container_insights" {
  description = "Enable or Disable Container Insights"
  type        = string
  default     = "yes"
}
variable "host_port" {
  description = "Host port to Map from Container Port."
  type        = string
  default     = 80
}
variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t3.small"
}
variable "launch_type" {
  description = "Launch type on which to run your service."
  type        = string
  default     = "EC2"
}
variable "load_balancer_internal" {
  description = "If true, the LB will be internal."
  type        = bool
  default     = false
}
variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application, gateway, or network. The default value is application."
  type        = string
  default     = "application"
  validation {
    condition     = contains(["application", "gateway", "network"], var.lb_type)
    error_message = "Valid values for load balancer type are application, gateway or network."
  }
}
variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host"
  type        = string
  default     = "bridge"
  validation {
    condition     = contains(["awsvpc", "none", "bridge", "host"], var.network_mode)
    error_message = "Valid values are awsvpc, none, bridge or host."
  }
}
variable "platform_version" {
  description = "Platform version on which to run your service. Only applicable for launch_type set to FARGATE."
  type        = string
  default     = "LATEST"
}
variable "prefix" {
  description = "Prefix to add into resources."
  type        = string
  default     = "orderful"
}
variable "requires_compatibilities" {
  description = "Set of launch types required by the task. The valid values are EC2 and FARGATE."
  type        = list(string)
  default     = ["EC2"]
  validation {
    condition     = var.requires_compatibilities != ["EC2"] || var.requires_compatibilities != ["FARGATE"]
    error_message = "Valid values are EC2 and FARGATE."
  }
}
variable "spot" {
  description = "Choose should we use spot instances or on-demand to populate ECS cluster."
  type        = bool
  default     = false
}
variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group."
  type        = string
  default     = "instance"
}
variable "task_definition_cpu" {
  description = "Number of cpu units used by the task."
  type        = number
  default     = 256
}
variable "task_definition_memory" {
  description = "Amount (in MiB) of memory used by the task."
  type        = number
  default     = 512
}
variable "wait_for_steady_state" {
  description = "Terraform will wait for the service to reach a steady state. Default true"
  type        = bool
  default     = true
}
variable "user_data" {
  description = "User data to provide when launching the instance."
  type        = list(string)
  default     = null
}
variable "target_group_health_checks" {
  description = "Health Check Configuration for Target group."
  type = object({
    path                = string
    protocol            = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    matcher             = string
  })

  default = {
    path                = "/api/health/check"
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = 200
  }
}
