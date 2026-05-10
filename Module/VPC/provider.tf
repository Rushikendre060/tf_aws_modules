# Terraform configuration block
terraform {

  # Required providers
  required_providers {

    # AWS provider
    aws {

      # Provider source
      source = "hashicorp/aws"

      # AWS provider version
      version = "6.5.0"
    }
  }
}

# AWS provider configuration
provider "aws" {

  # AWS region
  region = "ap-south-1"
}