resource "aws_db_instance" "rds" {
  allocated_storage     = 50
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t3.micro"
  name                  = "db_app"
  username              = "db_app_v1"
  password              = "db_app_v1"
  parameter_group_name  = "default.mysql5.7"
  skip_final_snapshot   = true
  multi_az              = true
  db_subnet_group_name  = var.output_db_subnet_group
  vpc_security_group_ids = [var.output_database_sg]
  max_allocated_storage = 100
  deletion_protection = true
}
