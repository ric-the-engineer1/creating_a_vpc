# AWS VPC Infrastructure Setup Project

## Project Overview
This project sets up a basic AWS Virtual Private Cloud (VPC) infrastructure using Terraform. It's designed as a foundation for a secure healthcare platform, implementing AWS best practices for networking and security.

## Prerequisites
- Ubuntu Server 22.04 LTS
- AWS Account with administrative access
- AWS Access and Secret keys
- Basic understanding of Linux commands

## Installation Steps

### 1. Initial Setup
Run the setup script to install necessary tools and create the project structure:
```bash
chmod +x setup.sh
./setup.sh

The script installs:

AWS CLI v2

Terraform

Required system packages

## AWS Configuration

Configure AWS CLI with your credentials:

aws configure

You'll need to enter:

AWS Access Key ID

AWS Secret Access Key

Default region (us-east-1)

Default output format (json)

3. Project Structure

The script creates the following directory structure:

terraform-aws-project/

├── vpc/

├── security/

└── modules/

Infrastructure Details

VPC Configuration

CIDR Block: 10.0.0.0/16

DNS hostnames enabled

DNS support enabled

Networking Components

Public Subnet

CIDR: 10.0.1.0/24

Availability Zone: us-east-1a

Auto-assign public IPs enabled


Internet Gateway

Attached to VPC

Enables internet connectivity


Route Table

Routes traffic to internet gateway

Associated with public subnet

Usage

Initialize Terraform

cd terraform-aws-project

terraform init

Plan Infrastructure

terraform plan -out=tfplan

Apply Infrastructure

terraform apply "tfplan"

Destroy Infrastructure

To remove all created resources:

terraform destroy

Project Files

setup.sh

Contains all necessary commands to set up the development environment and install required tools.

main.tf

Setting up your VPC region.

vpc/main.tf

Contains VPC infrastructure configuration including:

VPC creation

Subnet configuration

Internet Gateway setup

Route table configuration

Verification

Verify resource creation using AWS CLI:

# Check VPC

aws ec2 describe-vpcs --filters "Name=tag:Name,Values=secure-health-vpc"

# Check Subnet

aws ec2 describe-subnets --filters "Name=tag:Name,Values=public-subnet"

Common Issues and Solutions

AWS CLI Installation

If wget fails, ensure system is updated

Verify unzip is installed

Terraform Initialization

If initialization fails, check internet connectivity

Verify AWS credentials are configured correctly

AWS Permissions

Ensure IAM user has appropriate permissions

Verify AWS credentials are entered correctly


Next Steps

Add private subnets for better security

Implement NAT Gateway for private subnet internet access

Configure security groups and NACLs

Set up VPC endpoints for AWS services

Contributing

Feel free to submit issues and enhancement requests.

License

This project is licensed under the MIT License - see the LICENSE file for details.
