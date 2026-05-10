# Name used for resource naming
variable "name" {
  type = string
}

# VPC ID where resources will be created
variable "vpc_id" {
  type = string
}

# List of private subnet IDs for RDS deployment
variable "private_subnets" {
  type = list(string)
}

# CIDR blocks allowed to access MySQL
variable "allowed_cidrs" {
  type    = list(string)

  # Default allows access from anywhere
  default = ["0.0.0.0/0"]
}

# MySQL engine version
variable "mysql_engine_version" {
  type = string

  # Uses AWS default version if not specified
  default = null
}

# RDS instance type
variable "db_instance_class" {
  type = string

  # Default DB instance size
  default = "db.t3.micro"
}

# Storage size in GB
variable "db_allocated_storage" {
  type = number

  # Default storage size
  default = 20
}

# Master database username
variable "db_username" {
  type = string
}

# Master database password
variable "db_password" {
  type = string

  # Hides password from logs/output
  sensitive = true
}