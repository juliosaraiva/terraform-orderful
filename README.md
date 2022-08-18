<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./aws/compute/ecs | n/a |
| <a name="module_launch_template"></a> [launch\_template](#module\_launch\_template) | ./aws/compute/launch_template | n/a |
| <a name="module_security_groups"></a> [security\_groups](#module\_security\_groups) | ./aws/network/security_groups | n/a |
| <a name="module_subnet-us-east-1a"></a> [subnet-us-east-1a](#module\_subnet-us-east-1a) | ./aws/network/subnets | n/a |
| <a name="module_subnet-us-east-1b"></a> [subnet-us-east-1b](#module\_subnet-us-east-1b) | ./aws/network/subnets | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./aws/network/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->