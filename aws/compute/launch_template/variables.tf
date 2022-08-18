variable "ssh_public_key" {
  description = "You must specify your SSH Public key"
  type        = string
}

variable "ecs_security_groups" {
  description = "ECS Security Groups"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t3.small"
}

variable "prefix" {
  description = "Prefix to add into resources."
  type        = string
  default     = "orderful"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "user_data" {
  description = "The user data to provide when launching the instance."
  type        = string
  default     = null
}

variable "spot" {
  description = "Choose should we use spot instances or on-demand to populate ECS cluster."
  type        = bool
  default     = false
}
