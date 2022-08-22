terraform {
  cloud {
    organization = "julinuxops-demo"

    workspaces {
      name = "orderful-ecs"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.26.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Owner       = "DevOps"
      ManagedBy   = "Terraform"
      Environment = terraform.workspace
      Project     = "Orderful Devops Challenge"
    }
  }
}
