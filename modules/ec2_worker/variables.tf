variable "project_slug" {
  type        = string
  nullable    = false
  description = "A slugified name, used to label AWS resources."
}

variable "ssh_public_key" {
  type        = string
  nullable    = false
  description = "An SSH public key, to be installed on the EC2 workers."
}

variable "instance_type" {
  type        = string
  nullable    = false
  default     = "t3.small"
  description = "The EC2 workers' instance size."
}

variable "instance_quantity" {
  type        = number
  nullable    = false
  default     = 1
  description = "The quantity of EC2 worker instances."
}

variable "volume_size" {
  type        = number
  nullable    = false
  default     = 40
  description = "The size, in GB, of the root EBS volume for the EC2 workers."
}

variable "ami_id" {
  type        = string
  default     = ""
  description = "A custom AMI ID to use on the EC2 workers."
}
