locals {
  default_region = "ap-south-1"
  region         = get_env("REGION", local.default_region)

  # Debug log
  _print_debug   = run_cmd("echo", "Selected region is ${local.region}")
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "mayank8233"
    key            = "${local.region}/terraform.tfstate"
    region         = local.default_region
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
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