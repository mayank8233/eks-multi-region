locals {
  region         = get_env("AWS_REGION", "ap-south-1")
  vpc_cidr       = get_env("TF_VAR_VPC_CIDR", "10.0.0.0/16")
  public_subnet  = get_env("TF_VAR_PUBLIC_SUBNETS", "10.0.101.0/24,10.0.102.0/24")
  private_subnet = get_env("TF_VAR_PRIVATE_SUBNETS", "10.0.1.0/24,10.0.2.0/24")

  env_tags = {
    Environment = get_env("TF_VAR_ENVIRONMENT", "dev")
    Owner       = get_env("TF_VAR_OWNER", "admin")
  }

  vpc_name = get_env("TF_VAR_VPC_NAME", "default-vpc")
}

terraform {
  source = "../../modules/vpc"
}

inputs = {
  name               = local.vpc_name
  cidr_block         = local.vpc_cidr
  azs                = ["${local.region}a", "${local.region}b"]
  public_subnets     = split(",", local.public_subnet)
  private_subnets    = split(",", local.private_subnet)
  enable_nat_gateway = true
  single_nat_gateway = true
  tags               = local.env_tags
}