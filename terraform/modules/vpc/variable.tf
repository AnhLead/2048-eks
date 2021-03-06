variable "region" {
  description = "AWS region"
}

variable "name" {
  type        = string
  description = "AWS region"
}

variable "cluster_name" {
  type = string
  description = "cluster name"
}

variable "cidr" {
  description = "cidr range"
}

variable "private_subnets" {
  type    = list(string)
}

variable "public_subnets" {
  type    = list(string)
}

variable "tags" {
  type    = map(string)
}