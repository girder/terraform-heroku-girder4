output "cname" {
  value       = heroku_domain.heroku.cname
  description = "The CNAME traffic should route to."
}

output "app" {
  value       = heroku_app.heroku
  description = "The app."
}
