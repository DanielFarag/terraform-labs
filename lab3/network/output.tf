output "subnets" {
  value = aws_subnet.subnets
}


output "public_sg" {
  value=aws_security_group.public_sg
}

output "private_sg" {
  value=aws_security_group.private_sg
}

output "database_rds_sg" {
  value=aws_security_group.database_rds_sg
}

output "redis_sg" {
  value=aws_security_group.redis_sg
}

