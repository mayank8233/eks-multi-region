#!/bin/bash

echo "🏗  VPC Deployment via Terragrunt"
echo "--------------------------------"

read -p "Enter AWS Region [default: ap-south-1]: " region
region=${region:-ap-south-1}

read -p "Enter VPC CIDR Block [default: 10.0.0.0/16]: " vpc_cidr
vpc_cidr=${vpc_cidr:-10.0.0.0/16}

read -p "Enter Public Subnets (comma-separated) [default: 10.0.101.0/24,10.0.102.0/24]: " public_subnets
public_subnets=${public_subnets:-10.0.101.0/24,10.0.102.0/24}

read -p "Enter Private Subnets (comma-separated) [default: 10.0.1.0/24,10.0.2.0/24]: " private_subnets
private_subnets=${private_subnets:-10.0.1.0/24,10.0.2.0/24}

read -p "Enter Environment Tag (e.g., dev/prod) [default: dev]: " env
env=${env:-dev-1}

read -p "Enter Owner Tag [default: mayank]: " owner
owner=${owner:-mayank}

read -p "Enter VPC name (e.g., app-vpc-dev) [default: mayank-1]: " vpc_name
vpc_name=${vpc_name:-mayank-1}

echo ""
echo "🚀 Deploying VPC..."

AWS_REGION=$region \
TF_VAR_VPC_CIDR=$vpc_cidr \
TF_VAR_PUBLIC_SUBNETS=$public_subnets \
TF_VAR_PRIVATE_SUBNETS=$private_subnets \
TF_VAR_ENVIRONMENT=$env \
TF_VAR_OWNER=$owner \
TF_VAR_VPC_NAME=$vpc_name \
terragrunt apply --terragrunt-working-dir terragrunt/vpc