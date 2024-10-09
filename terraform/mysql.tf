resource "aws_db_instance" "my_mysql" {
  identifier        = "my-mysql-db"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  db_name           = "mydatabase"  # Use db_name instead of name
  username          = "admin"
  password          = "admin123"
  allocated_storage = 20

  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.default.id]
  backup_retention_period = 7
  multi_az = false
  storage_type = "gp2"
  skip_final_snapshot = true
  tags = {
    Name = "my-mysql-db"
  }
}

# Subnet Group for the RDS instance
resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.public[0].id, aws_subnet.public[1].id]

  tags = {
    Name = "my-db-subnet-group"
  }
}

# Security Group for the RDS instance
resource "aws_security_group" "default" {
  name        = "my-db-security-group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-db-security-group"
  }
}
