#!/bin/bash
set -e

# Update system
sudo yum update -y

# Install common dependencies
sudo yum install -y \
    wget \
    unzip \
    git \
    jq \
    docker

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Clean up
rm -rf awscliv2.zip aws
