# Creates a VPC
resource "aws_vpc" "this" {

  # Main CIDR block for VPC
  cidr_block = var.vpc_cidr

  # Enables internal DNS support
  enable_dns_support = true

  # Enables DNS hostnames inside VPC
  enable_dns_hostnames = true

  # Adds tags to VPC
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}

# Creates public subnets
resource "aws_subnet" "public" {

  # Creates multiple public subnets
  count = length(var.public_subnets)

  # Attach subnet to VPC
  vpc_id = aws_vpc.this.id

  # CIDR block for each subnet
  cidr_block = var.public_subnets[count.index]

  # Availability Zone for subnet
  availability_zone = var.azs[count.index]

  # Automatically assign public IP
  map_public_ip_on_launch = true

  # Tags for subnet
  tags = {
    Name = "${var.name}-public-${count.index}"
  }
}

# Creates private subnets
resource "aws_subnet" "private" {

  # Creates multiple private subnets
  count = length(var.private_subnets)

  # Attach subnet to VPC
  vpc_id = aws_vpc.this.id

  # CIDR block for subnet
  cidr_block = var.private_subnets[count.index]

  # Availability Zone
  availability_zone = var.azs[count.index]

  # Tags for subnet
  tags = {
    Name = "${var.name}-private-${count.index}"
  }
}

# Creates Internet Gateway
resource "aws_internet_gateway" "this" {

  # Attach IGW to VPC
  vpc_id = aws_vpc.this.id

  # Tags
  tags = {
    Name = "${var.name}-igw"
  }
}

# Creates Route Table for public traffic
resource "aws_route_table" "public" {

  # Attach route table to VPC
  vpc_id = aws_vpc.this.id

  # Route internet traffic through IGW
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

# Associates public subnets with route table
resource "aws_route_table_association" "public" {

  # Create association for each public subnet
  count = length(aws_subnet.public[*].id)

  # Public subnet ID
  subnet_id = aws_subnet.public[count.index].id

  # Route table ID
  route_table_id = aws_route_table.public.id
}