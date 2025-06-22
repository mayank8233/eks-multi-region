variable "region" {}
variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}