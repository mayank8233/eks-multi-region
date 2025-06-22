variable "name" {}
variable "cidr_block" {}
variable "azs" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "enable_nat_gateway" {
  type = bool
}
variable "single_nat_gateway" {
  type = bool
}
variable "tags" {
  type = map(string)
}