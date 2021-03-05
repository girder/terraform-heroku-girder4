variable "project_slug" {
  type        = string
  description = "A slugified name, used to label AWS resources."
}

variable "ssh_public_key" {
  type        = string
  description = "An SSH public key, to be installed on the EC2 workers."
}

variable "instance_type" {
  type        = string
  default     = "t3.small"
  description = "The EC2 workers' instance size."
}

variable "instance_quantity" {
  type        = number
  default     = 1
  description = "The quantity of EC2 worker instances."
}

variable "volume_size" {
  type        = number
  default     = 40
  description = "The size, in GB, of the root EBS volume for the EC2 workers."
}
