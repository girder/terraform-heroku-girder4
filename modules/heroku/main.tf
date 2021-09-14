data "heroku_team" "heroku" {
  name = var.team_name
}

resource "heroku_app" "heroku" {
  name   = var.app_name
  region = "us"
  organization {
    name = data.heroku_team.heroku.name
  }
  buildpacks = concat(var.additional_buildpacks, ["heroku/python"])
  acm        = true # SSL certs for custom domain

  # Auto-created (by addons) config vars:
  # * CLOUDAMQP_APIKEY
  # * CLOUDAMQP_URL
  # * DATABASE_URL
  # * PAPERTRAIL_API_TOKEN
  config_vars           = var.config_vars
  sensitive_config_vars = var.sensitive_config_vars
}

resource "heroku_formation" "heroku_web" {
  app      = heroku_app.heroku.id
  type     = "web"
  size     = var.web_dyno_size
  quantity = var.web_dyno_quantity
}

resource "heroku_formation" "heroku_worker" {
  app      = heroku_app.heroku.id
  type     = "worker"
  size     = var.worker_dyno_size
  quantity = var.worker_dyno_quantity
}

resource "heroku_addon" "heroku_postgresql" {
  app  = heroku_app.heroku.id
  plan = "heroku-postgresql:${var.postgresql_plan}"
}

resource "heroku_addon" "heroku_cloudamqp" {
  app  = heroku_app.heroku.id
  plan = "cloudamqp:${var.cloudamqp_plan}"
}

resource "heroku_addon" "heroku_papertrail" {
  app  = heroku_app.heroku.id
  plan = "papertrail:${var.papertrail_plan}"
}

resource "heroku_domain" "heroku" {
  app      = heroku_app.heroku.id
  hostname = var.fqdn
}
