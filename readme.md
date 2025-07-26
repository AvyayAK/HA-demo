# 🌐 HA Flask Demo — Modular Terraform Infrastructure

This repository provisions a **high-availability Flask application** on AWS using **modular Terraform**. It integrates networking, compute, security, monitoring, and DNS — all orchestrated through reusable modules.

---

## 📦 Modular Architecture Overview

Each component is abstracted into a dedicated module for scalability and reusability:

| Module        | Purpose                                                                 |
|---------------|-------------------------------------------------------------------------|
| `network`     | Creates VPC, public/private subnets across multiple AZs                 |
| `security`    | Defines security groups for ALB, EC2, and RDS with fine-grained rules   |
| `alb`         | Deploys Application Load Balancer with HTTPS listener and ACM cert      |
| `compute`     | Launches EC2 instances via Auto Scaling Group with Flask app            |
| `db`          | Provisions RDS instance in private subnet with Secrets Manager support  |
| `iam`         | Creates IAM roles and instance profiles for secure access               |
| `s3`          | Sets up S3 bucket for logs or artifacts                                 |
| `monitoring`  | Configures SNS alerts for EC2 termination events                        |

---

## 🛠️ Key Features

- **Multi-AZ Deployment** using `aws_availability_zones` data source
- **ACM Integration** for secure HTTPS via ALB
- **Route 53 DNS Mapping** to ALB using alias records
- **Secrets Manager** used to inject DB credentials securely
- **IAM Roles** scoped per service for least privilege
- **SNS Notifications** for EC2 lifecycle events
- **Modular Variables** for easy environment switching (`dev`, `prod`, etc.)

---

## 🚀 Deployment Steps

1. Clone the repo:
   ```bash
   git clone https://github.com/AvyayAK/HA-demo.git
   cd HA-demo

2.  Initialize Terraform:
    terraform init
3. - Plan the deployment:

terraform plan -var-file="env/dev.tfvars"
4. - Apply the infrastructure:

   terraform apply -var-file="env/dev.tfvars"

   HA-demo/
├── modules/
│   ├── alb/
│   ├── compute/
│   ├── db/
│   ├── iam/
│   ├── monitoring/
│   ├── network/
│   ├── s3/
│   └── security/
├── env/
│   ├── dev.tfvars
│   └── prod.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
