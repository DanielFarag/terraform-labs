resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.subnets["private_subnet_1"].id,
    aws_subnet.subnets["private_subnet_2"].id,
  ]
  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = var.rds.allocated_storage
  db_name              = var.rds.db_name
  engine               = var.rds.engine
  engine_version       = var.rds.engine_version
  instance_class       = var.rds.instance_class
  username             = var.rds.username
  password             = var.rds.password
  parameter_group_name = var.rds.parameter_group_name
  skip_final_snapshot  = var.rds.skip_final_snapshot
  vpc_security_group_ids = [aws_security_group.database_rds.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
}

output "rds_endpoint" {
  value = aws_db_instance.default.endpoint
}