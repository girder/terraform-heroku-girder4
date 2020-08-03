output "heroku_app" {
  value       = module.heroku.app
  description = "The Heroku app."
}

output "iam_user" {
  value       = aws_iam_user.heroku_user
  description = "The IAM user for Heroku."
}

output "storage_bucket" {
  value       = module.storage.bucket
  description = "The storage S3 bucket."
}
