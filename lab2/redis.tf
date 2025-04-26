resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [
    aws_subnet.subnets["private_subnet_1"].id,
    aws_subnet.subnets["private_subnet_2"].id,
  ] 
}

resource "aws_elasticache_replication_group" "redis" {
  description                   = var.redis.description
  replication_group_id          = var.redis.replication_group_id
  node_type                     = var.redis.node_type
  engine                        = var.redis.engine
  engine_version                = var.redis.engine_version
  port                          = var.redis.port
  automatic_failover_enabled    = var.redis.automatic_failover_enabled
  transit_encryption_enabled    = var.redis.transit_encryption_enabled

  subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids = [aws_security_group.redis.id]
}



output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}

#redis-replication-group.spysvj.ng.0001.use1.cache.amazonaws.com