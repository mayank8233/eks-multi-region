variable "bucket_name" {
  type = string
}

variable "lock_table_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {
    Terraform = "true"
    Environment = "bootstrap"
  }
}