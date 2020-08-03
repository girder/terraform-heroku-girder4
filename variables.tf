# Required variables
variable "project_slug" {
  type        = string
  description = "A slugified name, used to label resources."
}

variable "fqdn" {
  type        = string
  description = "The fully qualified domain name where the server will be available."
}

variable "heroku_team" {
  type = object({
    id   = string
    name = string
  })
  description = "The name of the Heroku team."
}

variable "route53_zone" {
  type = object({
    id      = string
    zone_id = string
    name    = string
  })
  description = "The Route 53 zone to create new DNS records within."
}

# Optional variables
variable "heroku_app_name" {
  type        = string
  default     = "" # Actual default is set internally
  description = "The name of the Heroku app."
}

variable "storage_bucket_name" {
  type        = string
  default     = "" # Actual default is set internally
  description = "The name of the Heroku app."
}

variable "django_default_from_email" {
  type        = string
  default     = "" # Actual default is set internally
  description = "The default email address which Django will send from."
}

variable "django_cors_origin_whitelist" {
  type        = list(string)
  default     = []
  description = "Domains which Django will allow to make CORS requests."
}
variable "django_cors_origin_regex_whitelist" {
  type        = list(string)
  default     = []
  description = "Domain regular expressions which Django will allow to make CORS requests."
}

variable "additional_django_vars" {
  type        = map(string)
  default     = {}
  description = "Additional Django environment variables."
}
variable "additional_sensitive_django_vars" {
  type        = map(string)
  default     = {}
  description = "Additional Django environment variables, which will not be printed."
}

variable "heroku_web_dyno_size" {
  type        = string
  default     = "hobby"
  description = "The Heroku web server dyno size."
}

variable "heroku_web_dyno_quantity" {
  type        = number
  default     = 1
  description = "The Heroku web server dyno quantity."
}

variable "heroku_worker_dyno_size" {
  type        = string
  default     = "hobby"
  description = "The Heroku worker dyno size."
}

variable "heroku_worker_dyno_quantity" {
  type        = number
  default     = 1
  description = "The Heroku worker dyno quantity."
}

variable "heroku_postgresql_plan" {
  type        = string
  default     = "hobby-dev"
  description = "The Heroku Postgres add-on plan type."
}

variable "heroku_cloudamqp_plan" {
  type        = string
  default     = "lemur"
  description = "The Heroku CloudAMQP add-on plan type."
}
