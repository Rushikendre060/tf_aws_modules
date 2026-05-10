# Creates a Security Group for MySQL database
resource "aws_security_group" "mysql" {

  # Security Group name
  name = "${var.name}-mysql-sg"

  # Description shown in AWS console
  description = "Allow MySQL inbound traffic"

  # Attach SG to this VPC
  vpc_id = var.vpc_id

  # Inbound rule
  ingress {

    # MySQL port starts from 3306
    from_port = 3306

    # MySQL port ends at 3306
    to_port = 3306

    # TCP protocol
    protocol = "tcp"

    # Allow access from these CIDR ranges
    cidr_blocks = var.allowed_cidrs
  }

  # Outbound rule
  egress {

    # Allow all outbound traffic
    from_port = 0
    to_port   = 0

    # -1 means all protocols
    protocol = "-1"

    # Allow internet access everywhere
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creates DB subnet group for RDS
resource "aws_db_subnet_group" "this" {

  # Name of subnet group
  name = "${var.name}-db-subnet-group"

  # Private subnets where RDS will be created
  subnet_ids = var.private_subnets
}

# Creates MySQL RDS instance
resource "aws_db_instance" "mysql" {

  # Unique database identifier
  identifier = "${var.name}-mysql"

  # Database engine type
  engine = "mysql"

  # MySQL version
  engine_version = var.mysql_engine_version

  # RDS instance size
  instance_class = var.db_instance_class

  # Storage size in GB
  allocated_storage = var.db_allocated_storage

  # Master DB username
  username = var.db_username

  # Master DB password
  password = var.db_password

  # Attach DB subnet group
  db_subnet_group_name = aws_db_subnet_group.this.name

  # Attach MySQL security group
  vpc_security_group_ids = [aws_security_group.mysql.id]

  # Skip snapshot during destroy
  skip_final_snapshot = true

  # Makes DB private
  publicly_accessible = false
}