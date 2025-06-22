#!/bin/bash

echo "☸️  EKS Deployment via Terragrunt"
echo "-------------------------------"

read -p "Enter AWS Region [default: ap-south-1]: " region
region=${region:-ap-south-1}

read -p "Enter EKS Cluster Name [default: mayank-eks]: " cluster_name
cluster_name=${cluster_name:-mayank-eks}

read -p "Enter EKS Cluster Version [default: 1.29]: " cluster_version
cluster_version=${cluster_version:-1.29}

read -p "Enter VPC ID (if using existing VPC) [default: leave blank to use Terragrunt dependency]: " vpc_id

if [[ -n "$vpc_id" ]]; then
  read -p "Enter Private Subnets (comma-separated): " private_subnets
fi

read -p "Enter Environment Tag (e.g., dev/prod) [default: dev]: " env
env=${env:-dev}

read -p "Enter Owner Tag [default: mayank]: " owner
owner=${owner:-mayank}

echo ""
echo "🚀 Deploying EKS..."

AWS_REGION=$region \
TF_VAR_CLUSTER_NAME=$cluster_name \
TF_VAR_CLUSTER_VERSION=$cluster_version \
TF_VAR_ENVIRONMENT=$env \
TF_VAR_OWNER=$owner \
${vpc_id:+TF_VAR_VPC_ID=$vpc_id} \
${private_subnets:+TF_VAR_PRIVATE_SUBNETS=$private_subnets} \
terragrunt run-all apply --terragrunt-working-dir terragrunt/eks