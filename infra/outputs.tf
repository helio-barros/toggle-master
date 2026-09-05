output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "ecr_repository_urls" {
  value = module.ecr.repository_urls
}

output "rds_endpoints" {
  value = module.rds.db_endpoints
}

output "rds_passwords" {
  value     = module.rds.db_passwords
  sensitive = true
}

output "redis_endpoint" {
  value = module.cache.redis_endpoint
}

output "redis_port" {
  value = module.cache.redis_port
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "sqs_queue_url" {
  value = module.messaging.queue_url
}

output "sqs_dlq_url" {
  value = module.messaging.dlq_url
}
