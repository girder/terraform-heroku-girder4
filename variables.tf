# Required variables
variable "project_slug" {
  type        = string
  description = "A slugified name, used to label resources."
}

variable "subdomain_name" {
  type        = string
  description = "The DNS subdomain name where the server will be available."
}

variable "heroku_team_name" {
  type        = string
  description = "The name of the Heroku team for the app."
}

variable "route53_zone_id" {
  type        = string
  description = "The Route 53 zone ID to create new DNS records within."
}

# Optional variables
variable "heroku_app_name" {
  type        = string
  default     = "" # Actual default is set internally
  description = "The name of the Heroku app."
}

variable "heroku_additional_buildpacks" {
  type        = list(string)
  default     = []
  description = "Additional buildpacks to use on Heroku."
}

variable "storage_bucket_name" {
  type        = string
  default     = "" # Actual default is set internally
  description = "The globally unique S3 bucket name of the storage."
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
  sensitive   = true
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

variable "heroku_papertrail_plan" {
  type        = string
  default     = "choklad"
  description = "The Heroku Papertrail add-on plan type."
}

variable "ec2_worker_ssh_public_key" {
  type        = string
  default     = ""
  description = "An SSH public key, to be installed on the EC2 workers. This must be set if ec2_worker_instance_quantity > 0."
}

variable "ec2_worker_instance_type" {
  type        = string
  default     = "t3.small"
  description = "The EC2 workers' instance size."
}

variable "ec2_worker_instance_quantity" {
  type        = number
  default     = 0
  description = "The quantity of EC2 worker instances."
}

variable "ec2_worker_volume_size" {
  type        = number
  default     = 40
  description = "The size, in GB, of the root EBS volume for the EC2 workers."
}
