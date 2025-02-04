#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update
sudo apt upgrade -y

# Install required packages
echo "Installing required packages..."
sudo apt install -y unzip

# Install AWS CLI v2
echo "Installing AWS CLI version 2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm awscliv2.zip
rm -rf aws

# Install Terraform
echo "Installing Terraform..."
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update
sudo apt install -y terraform

# Create project directory structure
echo "Creating project directory structure..."
mkdir -p ~/terraform-aws-project
cd ~/terraform-aws-project
mkdir -p {vpc,security,modules}

# Verify installations
echo "Verifying installations..."
aws --version
terraform --version

echo "Setup complete! Next steps:"
echo "1. Configure AWS credentials using 'aws configure'"
echo "2. Begin creating Terraform configuration files"