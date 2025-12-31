resource "aws_security_group" "mysql" {
  name        = "${var.name}-mysql-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mysql" {
  identifier             = "${var.name}-mysql"
  engine                 = "mysql"
  engine_version         = var.mysql_engine_version
  instance_class         = var.db_instance_class
  allocated_storage      = var.db_allocated_storage
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.mysql.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
}