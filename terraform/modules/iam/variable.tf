variable "provider_arn" {
  type        = string
}

variable "tags" {
  type    = map(string)
}

variable "external_dns_hosted_zone_arns" {
  type = any
}