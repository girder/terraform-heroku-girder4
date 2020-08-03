output "heroku_app_id" {
  value       = module.heroku.app_id
  description = "The Heroku app ID."
}

output "iam_user" {
  value       = aws_iam_user.heroku_user
  description = "The IAM user for Heroku."
}
