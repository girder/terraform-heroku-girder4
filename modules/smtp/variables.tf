variable "project_slug" {
  type        = string
  description = "A slugified name, used to label AWS resources."
}

variable "route53_zone_id" {
  type        = string
  description = "The Route 53 zone ID to create new DNS records within."
}

variable "fqdn" {
  type        = string
  description = "The fully-qualified domain name for outgoing emails."
}
