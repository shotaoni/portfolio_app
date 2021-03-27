resource "aws_db_parameter_group" "tante-db-parameter-group" {
  name   = "tante-db-parameter-group"
  family = "mysql5.7"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_instance" "tante-db" {
  identifier                 = "tante-db"
  engine                     = "mysql"
  engine_version             = "5.7.25"
  instance_class             = "db.t3.micro"
  allocated_storage          = 20
  max_allocated_storage      = 100
  storage_type               = "gp2"
  username                   = var.DB_USERNAME
  password                   = var.DB_PASSWORD
  multi_az                   = true
  publicly_accessible        = true
  backup_window              = "09:10-09:40"
  backup_retention_period    = 30
  maintenance_window         = "mon:10:10-mon:10:40"
  auto_minor_version_upgrade = false
  deletion_protection        = false
  skip_final_snapshot        = true
  port                       = 3306
  apply_immediately          = false
  vpc_security_group_ids     = [aws_security_group.tante-rds-sg.id]
  parameter_group_name       = aws_db_parameter_group.tante-db-parameter-group.name
  db_subnet_group_name       = aws_db_subnet_group.tante-rds-subnet-group.name
  enabled_cloudwatch_logs_exports = [
    "audit",
    "error",
    "general",
    "slowquery",
  ]
}