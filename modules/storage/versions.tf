terraform {
  required_version = ">= 1.1"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      # 4.9 includes backwards-compatible aws_s3_bucket syntax,
      # which makes globally upgrading the aws provider easier
      version = ">= 4.9.0"
    }
  }
}
