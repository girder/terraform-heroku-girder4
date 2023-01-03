terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # Required for https://github.com/hashicorp/terraform-provider-aws/pull/26716
      version = ">= 4.30.0"
    }
  }
}
