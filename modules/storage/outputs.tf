output "bucket_name" {
  value       = aws_s3_bucket.storage.id
  description = "The S3 bucket name."
}

output "bucket_arn" {
  value       = aws_s3_bucket.storage.arn
  description = "The S3 bucket ARN."
}

output "django_policy" {
  value       = data.aws_iam_policy_document.storage_django.json
  description = "The IAM policy for Django access to the storage bucket."
}
