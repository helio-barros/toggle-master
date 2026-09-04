output "db_endpoints" {
  value = { for k, v in aws_db_instance.main : k => v.endpoint }
}

output "db_passwords" {
  value     = { for k, v in random_password.db : k => v.result }
  sensitive = true
}

output "security_group_id" {
  value = aws_security_group.rds.id
}
