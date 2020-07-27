output "django_policy" {
  value       = data.aws_iam_policy_document.storage_django.json
  description = "The IAM policy for Django access to the storage bucket."
}
