output "fqdn" {
  value = aws_route53_record.heroku.fqdn
  description = "The fully-qualified domain name of the Heroku app."
}

output "heroku_app_id" {
  value       = module.heroku.app_id
  description = "The ID of the Heroku app."
}

output "iam_user_id" {
  value       = aws_iam_user.heroku_user.id
  description = "The ID of the IAM user for Heroku."
}

output "storage_bucket_name" {
  value       = module.storage.bucket_name
  description = "The storage S3 bucket name."
}
