# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.project_name}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-rds-subnet-group"
  }
}

# RDS PostgreSQL Instance
resource "aws_db_instance" "postgres" {
  identifier                  = "${var.project_name}-db"
  engine                      = "postgres"
  engine_version              = data.aws_rds_engine_version.postgresql.version
  instance_class              = "db.t3.micro"
  allocated_storage           = 20
  storage_type                = "gp2"
  username                    = var.db_username
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids      = [aws_security_group.rds.id]
  multi_az                    = false
  publicly_accessible         = false
  storage_encrypted           = true
  backup_retention_period     = 7
  copy_tags_to_snapshot       = true
  deletion_protection         = var.deletion_protection
  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : coalesce(
    var.final_snapshot_identifier,
    "${var.project_name}-final-snapshot",
  )

  tags = {
    Name = "${var.project_name}-rds"
  }
}
