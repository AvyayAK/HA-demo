provider "aws" {
  region     = "ap-south-1"
  #access_key = "<your-access-key>"
  #secret_key = "<your-secret-key>"
}
#needed for private subnet for db
data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

locals {
  common_tags = {
    Project     = "HA-Flask-Demo"
    Environment = "dev"
    Owner       = "Swathi"
    ManagedBy   = "Terraform"
  }
}

data "aws_acm_certificate" "selected" {
  domain      = "*.swathi-apps.cloud"
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "selected" {
  zone_id = "Z0895668B7PNXFD9BVZB"
  #private_zone = false
}

module "network" {
  source               = "./modules/network"
  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  az_1                 = var.az_1
  az_2                 = var.az_2
 region          = var.region
 azs                   = local.azs

}

module "security" {
  source             = "./modules/security"
  vpc_id             = module.network.vpc_id
  allowed_ssh_cidrs  = var.allowed_ssh_cidrs
  allowed_https_cidrs = var.allowed_https_cidrs	
}

module "alb" {
  
  source             = "./modules/alb"
  vpc_id             = module.network.vpc_id
  subnet_ids         = module.network.public_subnet_ids
  sg_id              = module.security.alb_sg_id
  alb_name           = var.alb_name
  target_group_name  = var.target_group_name
  certificate_arn  = data.aws_acm_certificate.selected.arn
}
resource "aws_route53_record" "app_root" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "swathi-apps.cloud"
  type    = "A"

  alias {
    name                   = module.alb.alb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }
}	
module "compute" {
  source            = "./modules/compute"
  instance_type     = var.instance_type
  subnet_ids        = module.network.public_subnet_ids
  sg_id                     = [
    module.security.alb_sg_id,
    module.security.ec2_sg_id,
    module.security.rds_sg_id
  ]
  flask_target_group_arn = module.alb.flask_target_group_arn
 iam_instance_profile_name = module.iam.ec2_profile_name
  db_host         = module.db.rds_hostname
  db_name         = "flasklogs"
  db_user         = "flaskadmin"
  db_password     = var.db_password
  #s3_bucket_name  = module.s3.bucket_name
  s3_bucket_name  = var.bucket_name
#depends_on = [module.db]
}

module "iam" {
  source        = "./modules/iam"
  role_name     = var.role_name
  bucket_name   = var.bucket_name
tags        = local.common_tags

}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.bucket_name
}

#module "dns" {
  #source         = "./modules/dns"
  #domain_name    = var.domain_name
  #lb_dns_name    = module.alb.alb_dns_name
  #lb_zone_id     = module.alb.lb_zone_id
  #subdomains     = []  //  Optional: you can remove this line if your module uses a default
#}

module "db" {
  source        = "./modules/db"
  db_name       = "flasklogs"
  db_username   = "flaskadmin"
  db_password   = var.db_password
  vpc_id        = module.network.vpc_id
  subnet_ids    = module.network.private_subnets
db_sg_id    = module.security.rds_sg_id
}

module "monitoring" {
  source            = "./modules/monitoring"
  notification_email = var.email-id
}