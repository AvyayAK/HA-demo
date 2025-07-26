# Network
variable "vpc_name" {
  type    = string
  default = "main-vpc"
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  type    = string
  default = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  type    = string
  default = "10.0.2.0/24"
}
variable "az_1" {
  type    = string
  default = "ap-south-1a"
}
variable "az_2" {
  type    = string
  default = "ap-south-1b"
}

# Security
variable "sg_name" {
  type    = string
  default = "web-sg"
}
variable "allowed_ssh_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}
variable "allowed_https_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

# ALB
variable "alb_name" {
  type    = string
  default = "web-alb"
}
variable "target_group_name" {
  type    = string
  default = "web-tg"
}

# Compute
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

#role
variable "role_name" {
  type    = string
  default = "ec2-s3-access-role"
}

#s3bucket
variable "bucket_name" {
  type    = string
  default = "devops-demo-bucket"
}

variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "domain_name" {
  description = "Root domain name"
  type        = string
}

variable "subdomains" {
  description = "List of subdomains"
  type        = list(string)
}
#for db
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}	

variable "db_password" {
description = "db password"
type = string
}

variable "email-id" {
  type    = string
  default = "your-email@example.com"
}