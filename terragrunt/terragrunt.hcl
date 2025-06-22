locals {
  region          = get_env("AWS_REGION", "us-east-1")
  cluster_name    = get_env("TF_VAR_CLUSTER_NAME", "default-eks")
  cluster_version = get_env("TF_VAR_CLUSTER_VERSION", "1.29")
  vpc_cidr        = get_env("TF_VAR_VPC_CIDR", "10.0.0.0/16")
  public_subnet   = split(",", get_env("TF_VAR_PUBLIC_SUBNETS", "10.0.101.0/24,10.0.102.0/24"))
  private_subnet  = split(",", get_env("TF_VAR_PRIVATE_SUBNETS", "10.0.1.0/24,10.0.2.0/24"))

  env_tags = {
    Environment = get_env("TF_VAR_ENVIRONMENT", "dev")
    Owner       = get_env("TF_VAR_OWNER", "admin")
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "mayank8233"
    key            = "${local.region}/${local.cluster_name}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region  = "${local.region}"
  profile = "personal"
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}