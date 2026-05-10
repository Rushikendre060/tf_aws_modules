# Name used for resource naming
variable "name" {
  type = string
}

# VPC CIDR block
variable "vpc_cidr" {
  type = string

  # Default VPC CIDR
  default = "10.0.0.0/16"
}

# List of public subnet CIDRs
variable "public_subnets" {
  type = list(string)
}

# List of private subnet CIDRs
variable "private_subnets" {
  type = list(string)
}

# Availability Zones list
variable "azs" {
  type = list(string)
}

# Common tags for resources
variable "tags" {
  type = map(string)

  # Empty default tags
  default = {}
}