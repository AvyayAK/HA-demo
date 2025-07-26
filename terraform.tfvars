# Network Config
vpc_name             = "devops-vpc"
vpc_cidr             = "10.0.0.0/16"
public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"
az_1                 = "ap-south-1a"
az_2                 = "ap-south-1b"

# Security Group Config
sg_name              = "devops-web-sg"
allowed_ssh_cidrs    = ["0.0.0.0/0"]
allowed_https_cidrs  = ["0.0.0.0/0"]

# Load Balancer Config
alb_name             = "devops-alb"
target_group_name    = "devops-web-tg"

#  Compute Config
instance_type        = "t2.micro"
role_name   = "ec2-s3-access-role"

#s3
bucket_name = "devops-demo-bucket-swathi"

#generic
region      = "ap-south-1"

#r53
domain_name = "swathi-apps.cloud"
subdomains = [
  "swathi-apps.cloud"
 ]

# for database
private_subnet_cidrs = [
  "10.0.4.0/24",
  "10.0.5.0/24",
  "10.0.6.0/24"
]

db_username = "flaskadmin"
db_password = "*********"

email-id = "***********"
