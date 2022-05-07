variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "cluster_version" {
  default     = "1.21"
  type        = string
  description = "Cluster version"
}

variable "tags" {
  type    = map(string)
}

variable "max_unavailable_percentage" {
  type        = number
}

variable "environment" {
  type        = string
}

variable "instance_types" {
  type        = list(string)
}

variable "subnet_ids" {
  type        = list(string)
}

variable "vpc_id" {
  type        = string
}

variable "service_account_role_arn" {
  type        = string
}

variable "cluster_ip_family" {
  type        = string
}

variable "cluster_endpoint_public_access" {
  type        = bool
}

variable "cluster_endpoint_private_access" {
  type        = bool
}

variable "manage_aws_auth_configmap" {
  type    = bool
  default = true
}
