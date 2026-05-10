# Outputs VPC ID
output "vpc_id" {

  # Description of output
  description = "The ID of the VPC"

  # Actual VPC ID value
  value = aws_vpc.this.id
}

# Outputs all public subnet IDs
output "public_subnet_ids" {

  # Description
  description = "List of public subnet IDs"

  # Public subnet ID list
  value = aws_subnet.public[*].id
}

# Outputs all private subnet IDs
output "private_subnet_ids" {

  # Description
  description = "List of private subnet IDs"

  # Private subnet ID list
  value = aws_subnet.private[*].id
}