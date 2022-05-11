variable "region" {
  default     = "eu-west-2"
  description = "AWS region"
}

variable "tags" {
  type    = map(string)
  default = {
    terraform   = "true"
    environment = "staging"
  }
}

################################################################################
# VPC
################################################################################

variable "name" {
  default     = "vpc"
  type        = string
  description = "AWS region"
}

variable "cidr" {
  default     = "10.0.0.0/16"
  description = "cidr range"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

################################################################################
# EKS
################################################################################

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "dev-cluster"
}

variable "cluster_version" {
  default     = "1.21"
  type        = string
  description = "Cluster version"
}

variable "max_unavailable_percentage" {
  type    = number
  default = 50
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.large", "t3.medium", "t3.small", "t3.micro"]
}

variable "cluster_ip_family" {
  type    = string
  default = "ipv6"
}

variable "cluster_endpoint_public_access" {
  type    = bool
  default = true
}

variable "cluster_endpoint_private_access" {
  type    = bool
  default = true
}

################################################################################
# ROUTE53
################################################################################

variable "zones" {
  type    = any
  default = {
    "anhtran.be" = {
      comment = "Hosted by Terraform"
      tags =  {
        terraform   = "true"
      }
    }
  }
  
}
