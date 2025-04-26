env="prod"
region = "eu-central-1"
instance_type="t2.micro"
vpc_cidr_block="10.0.0.0/16"

subnets = [ {
  name = "public_subnet_1"
  availability_zone = "eu-central-1a"
  cidr_block = "10.0.1.0/24"
  public = true
}, {
  name = "private_subnet_1"
  availability_zone = "eu-central-1b"
  cidr_block = "10.0.2.0/24"
  public = false
}, {
  name = "private_subnet_2"
  availability_zone = "eu-central-1a"
  cidr_block = "10.0.3.0/24"
  public = false
}]


rds = {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

redis = {
  description                   = "Redis Service"
  replication_group_id          = "redis-replication-group"
  node_type                     = "cache.t4g.micro"
  engine                        = "redis"
  engine_version                = "7.0"
  port                          = 6379
  automatic_failover_enabled    = false
  transit_encryption_enabled    = false
}