output "heroku_app_id" {
  value       = module.heroku.app_id
  description = "The Heroku app ID."
}

output "iam_user_id" {
  value       = aws_iam_user.heroku_user.id
  description = "The ID of the IAM user for Heroku."
}
