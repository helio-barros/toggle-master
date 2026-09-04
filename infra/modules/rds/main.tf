resource "aws_db_subnet_group" "main" {
  name       = "${var.environment}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_security_group" "rds" {
  name        = "${var.environment}-rds-sg"
  description = "Permite Postgres apenas de dentro da VPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "Postgres a partir da VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.environment}-rds-sg" }
}

resource "random_password" "db" {
  for_each = var.databases
  length   = 20
  special  = false
}

resource "aws_db_instance" "main" {
  for_each = var.databases

  identifier              = "${var.environment}-${each.key}-db"
  engine                  = "postgres"
  engine_version          = "14"
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_name                 = each.value
  username                = "master"
  password                = random_password.db[each.key].result
  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
  backup_retention_period = 1
  multi_az                = false

  tags = { Name = "${var.environment}-${each.key}-db" }
}
