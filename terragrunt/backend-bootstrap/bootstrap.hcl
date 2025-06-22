include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/backend-bootstrap"
}

inputs = {
  bucket_name     = "my-terragrunt-state-bucket"
  lock_table_name = "terraform-locks"
}