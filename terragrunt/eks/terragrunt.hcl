locals {
  region = get_env("REGION", "ap-south-1")
}

terraform {
  source = "../../modules/eks"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  region       = local.region
  cluster_name = "eks-${local.region}"
#   vpc_id       = "vpc-07b7a6373190b3eb4"
  vpc_id       = dependency.vpc.outputs.vpc_id
  subnet_ids   = dependency.vpc.outputs.private_subnets
#   subnet_ids   = ["subnet-06ad208f89640b38f",
#     "subnet-01e694d050b9c90fa",
#     "subnet-0a7564626f31d2062",
#     "subnet-06488590ee6363b43",
#     "subnet-01ac870de2901991e",
#     "subnet-07d4ab740fb385c86"]  # Add both subnets
}