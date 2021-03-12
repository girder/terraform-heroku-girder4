output "cname" {
  value       = heroku_domain.heroku.cname
  description = "The CNAME traffic should route to."
}

output "app_id" {
  value       = heroku_app.heroku.id
  description = "The app ID."
}

output "all_config_vars" {
  value       = heroku_app.heroku.all_config_vars
  description = "All app environment variables, as they are effectively set."
  sensitive   = true
}
