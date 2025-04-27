resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [
    module.network.subnets["private_subnet_1"].id,
    module.network.subnets["private_subnet_2"].id,
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
  security_group_ids = [module.network.redis_sg.id]
}



output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}