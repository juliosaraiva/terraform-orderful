# AWS Orderful ECS Project

## Architecture
![alt AWS ECS Architecture](./images/IT%20services.svg)

## Configuring

### How to run this module

#### Using Terraform Cloud
In order to run this module using shared state, you must configure terraform cloud.

1. [Create a terraform cloud account](https://learn.hashicorp.com/tutorials/terraform/cloud-sign-up#create-an-account)
2. [Create an Organization](https://learn.hashicorp.com/tutorials/terraform/cloud-sign-up#create-an-organization)
3. [Create the workspace](https://learn.hashicorp.com/tutorials/terraform/cloud-workspace-create?in=terraform/cloud-get-started#create-the-workspace)
4. [Assign variables to the Workspace](https://learn.hashicorp.com/tutorials/terraform/cloud-workspace-create?in=terraform/cloud-get-started#assign-variable-set-to-workspace)

> Check the [Inputs](#inputs) section what variables are required to configure for this project and add it into your workspace.

Running terraform apply

```
export TF_CLOUD_ORGANIZATION=YOUR_ORGANIZATION_HERE
export TF_WORKSPACE=YOUR_WORKSPACE_HERE
terraform apply -var-file="sample.tfvars"
```

#### Using local state
Remove the line `2` from `terraform.tf` in order to create a `terraform.tfstate` file locally, then run `terraform init`. Run the following command to create terraform resources.
```
terraform apply -var-file="sample.tfvars"
```

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
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ./aws/compute/ecs | 0.0.1 |
| <a name="module_subnet-us-east-1a"></a> [subnet-us-east-1a](#module\_subnet-us-east-1a) | ./aws/network/subnets | 0.0.1 |
| <a name="module_subnet-us-east-1b"></a> [subnet-us-east-1b](#module\_subnet-us-east-1b) | ./aws/network/subnets | 0.0.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./aws/network/vpc | 0.0.1 |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | (Required) The public key material | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint_url"></a> [endpoint\_url](#output\_endpoint\_url) | Cloudfront Endpoint to access the application. |
<!-- END_TF_DOCS -->