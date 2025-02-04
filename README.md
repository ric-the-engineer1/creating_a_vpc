creating_a_vpc

How to create a AWS VPC using bash and terraform on a Ubuntu 22.04 LTS.

STEP 1: Initializing Server Setup

The first step is updating and upgrading your operating system. We will be using bash scripting for this.

sudo apt update

sudo apt upgrade -y

Install Required Packages

Install unzip (needed for Terraform)

sudo apt install unzip

Install AWS CLI

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install

Install Terraform

sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \

gpg --dearmor | \

sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform

Verify Installations

Aws - - version

Terraform - - version

STEP 2: CONFIGURE AWS

Set Up AWS Credentials:

Aws configure

Enter:

AWS Access Key ID: [Your Access Key]

AWS Secret Access Key: [Your Secret Key]

Default region name: us-east-1

Default output format: json

Verify AWS Configuration:

Aws sts get-caller-identity 

STEP 3: CREATE PROJECT STRUCTURE

Create Project Directory

Mkdir -p ~/terraform-aws-project

Cd ~/terraform-aws-project

Create the directory structure

Mkdir -p {vpc,security,modules}

Create a base Terraform configuration file:

Create and edit the main configuration file

Nano main.tf

Then Add This Content:

terraform {

  required_providers {
	
   aws = {
  	     source  = "hashicorp/aws"
  	     version  = "~> 5.0"
	}
  }
}


provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source = "./vpc"
}
Save and Exit (Ctrl+X, then Y, then Enter).

Create VPC Configuration:

Nano vpc/main.tf

Add this Content:

Create VPC

resource "aws_vpc" "main" {
  cidr_block       	      = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support       = true


  tags = {
	Name = "secure-health-vpc"
  }
}

Create Public Subnet

resource "aws_subnet" "public" {
  vpc_id              	            = aws_vpc.main.id
  cidr_block          	            = "10.0.1.0/24"
  availability_zone   	            = "us-east-1a"
  map_public_ip_on_launch = true


  tags = {
	Name = "public-subnet"
  }
}

Create Internet Gateway

resource "aws_internet_gateway" "main" {
  
  vpc_id = aws_vpc.main.id


  tags = {
	
  Name = "main-igw"
  }
}

Create Route Table

resource "aws_route_table" "public" {
  
  vpc_id = aws_vpc.main.id


  route {
	
  cidr_block = "0.0.0.0/0"
	
  gateway_id = aws_internet_gateway.main.id
  }


  tags = {
	
  Name = "public-rt"
  }
}


Associate Route Table with Subnet

resource "aws_route_table_association" "public" {

  subnet_id  	    = aws_subnet.public.id
  
  route_table_id = aws_route_table.public.id
}

STEP 4: INITIALIZE AND APPLY

Initialize Terraform

cd ~/terraform-aws-project

terraform init

Format and Validate your configuration

terraform fmt

terraform validate

Plan Your Infrastructure

terraform plan -out=tfplan

Apply the configuration:

terraform apply "tfplan"

STEP 5: VERIFY AND MONITOR

Check AWS Console for resources

aws ec2 describe-vpcs --filters "Name=tag:Name,Values=secure-health-vpc"

aws ec2 describe-subnets --filters "Name=tag:Name,Values=public-subnet"

Monitor your AWS costs:

aws ce get-cost-and-usage \

  --time-period Start=$(date -d "-30 days" +%Y-%m-%d),End=$(date +%Y-%m-%d) \
	
  --granularity MONTHLY \
	
  --metrics UnblendedCost

To Delete and Clean Up

terraform destroy
