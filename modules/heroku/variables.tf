variable "team_name" {
  type        = string
  description = "The name of the team."
}

variable "app_name" {
  type        = string
  description = "The name of the app."
}

variable "config_vars" {
  type        = map(string)
  description = "App environment variables, which will not be printed."
}

variable "sensitive_config_vars" {
  type        = map(string)
  description = "App environment variables."
}

variable "fqdn" {
  type        = string
  description = "The fully-qualified domain name of the app."
}

# Optional variables
variable "web_dyno_size" {
  type        = string
  default     = "hobby"
  description = "The web server dyno size."
}

variable "web_dyno_quantity" {
  type        = number
  default     = 1
  description = "The web server dyno quantity."
}

variable "worker_dyno_size" {
  type        = string
  default     = "hobby"
  description = "The worker dyno size."
}

variable "worker_dyno_quantity" {
  type        = number
  default     = 1
  description = "The worker dyno quantity."
}

variable "postgresql_plan" {
  type        = string
  default     = "hobby-dev"
  description = "The Heroku Postgres add-on plan type."
}

variable "cloudamqp_plan" {
  type        = string
  default     = "lemur"
  description = "The CloudAMQP add-on plan type."
}
