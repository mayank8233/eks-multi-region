include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/backend-bootstrap"
}

inputs = {
  bucket_name    = read_input("Enter S3 bucket name for state backend:")
  dynamodb_table = read_input("Enter DynamoDB table name for state locking:")
  region         = local.region
}