output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "security_group_id" {
  value = module.security.alb_sg_id
}

output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "target_group_arn" {
  value = module.alb.flask_target_group_arn
}

output "asg_name" {
  value = module.compute.asg_name
}

output "rds_endpoint" {
description = "RDS ENDPOINT"
value = module.db.db_endpoint
}

#flask_logs
output "rds_hostname" {
  value = module.db.rds_hostname
}