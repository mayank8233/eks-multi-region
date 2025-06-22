locals {
  region = get_env("REGION", "ap-south-1")
}

terraform {
  source = "../../modules/vpc"
}

inputs = {
  name            = "vpc-${local.region}"
  cidr_block      = "10.0.0.0/16"
  azs             = ["${local.region}a", "${local.region}b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}