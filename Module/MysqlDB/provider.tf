# Terraform configuration block
terraform {

  # Required providers for this module
  required_providers {

    # AWS provider configuration
    aws {

      # Provider source from HashiCorp registry
      source = "hashicorp/aws"

      # AWS provider version
      version = "6.5.0"
    }
  }
}

# AWS provider block
provider "aws" {

  # AWS region where infrastructure will be created
  region = "ap-south-1"
}
