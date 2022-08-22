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
