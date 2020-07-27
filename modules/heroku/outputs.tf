output "cname" {
  value       = heroku_domain.heroku.cname
  description = "The CNAME traffic should route to."
}

output "app_id" {
  value       = heroku_app.heroku.id
  description = "The app ID."
}
