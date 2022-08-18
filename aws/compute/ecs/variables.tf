// Required
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "execution_role_arn" {
  description = "Instance Role for ECS Service"
  type        = string
}
variable "ecs_security_group" {
  description = "Security Groups to allow in ECS SG"
  type        = list(string)
}
// Required

variable "container_port" {
  description = "Container Port to Listen On"
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

variable "custom_security_groups" {
  description = "Customized Security Groups to attach into the instance."
  type        = list(string)
  default     = []
}

variable "launch_type" {
  description = "Launch type on which to run your service."
  type        = string
  default     = "EC2"
}

variable "network_mode" {
  description = "Docker networking mode to use for the containers in the task. Valid values are none, bridge, awsvpc, and host"
  type        = string
  default     = "bridge"
  validation {
    condition     = contains(["awsvpc", "none", "bridge", "host"], var.network_mode)
    error_message = "The valid values are awsvpc, none, bridge or host."
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

// Required
variable "launch_template_id" {
  description = "(Required) The ID of the target. This is the Instance ID for an instance, or the container ID for an ECS container."
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public Subnet ID"
  type        = list(string)
}
// Required

variable "target_type" {
  description = "Type of target that you must specify when registering targets with this target group."
  type        = string
  default     = "instance"
}

variable "lb_internal" {
  description = "If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "lb_type" {
  description = "The type of load balancer to create. Possible values are application, gateway, or network. The default value is application."
  type        = string
  default     = "application"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "target_group_health_check" {
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
