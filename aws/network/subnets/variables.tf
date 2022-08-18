variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "prefix" {
  description = "Prefix to add into resources."
  type        = string
  default     = "orderful"
}

variable "private_subnet_cidr" {}
variable "public_subnet_cidr" {}
variable "internet_gateway_id" {}
variable "availability_zone" {}
variable "rtb_public_id" {}
