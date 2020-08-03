output "bucket" {
  value       = aws_s3_bucket.storage
  description = "The S3 bucket."
}

output "django_policy" {
  value       = data.aws_iam_policy_document.storage_django.json
  description = "The IAM policy for Django access to the storage bucket."
}
