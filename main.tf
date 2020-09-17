data "aws_region" "current" {} # auto-populated

locals {
  fqdn = "${var.subdomain_name}.${data.aws_route53_zone.current.name}"
  # Variable defaults cannot be directly based on other variables
  heroku_app_name           = var.heroku_app_name != "" ? var.heroku_app_name : var.project_slug
  storage_bucket_name       = var.storage_bucket_name != "" ? var.storage_bucket_name : "${var.project_slug}-storage"
  django_default_from_email = var.django_default_from_email != "" ? var.django_default_from_email : "admin@${local.fqdn}"
}

data "aws_route53_zone" "current" {
  zone_id = var.route53_zone_id
}

module "storage" {
  source      = "./modules/storage"
  bucket_name = local.storage_bucket_name
}

module "smtp" {
  source  = "girder/girder/aws//modules/smtp"
  version = "0.2.0"

  fqdn            = local.fqdn
  project_slug    = var.project_slug
  route53_zone_id = data.aws_route53_zone.current.zone_id
}

resource "random_string" "django_secret" {
  length  = 64
  special = false
}

module "heroku" {
  source = "./modules/heroku"

  team_name = var.heroku_team_name
  app_name  = local.heroku_app_name
  fqdn      = local.fqdn

  config_vars = merge(
    {
      AWS_ACCESS_KEY_ID                  = aws_iam_access_key.heroku_user.id
      AWS_DEFAULT_REGION                 = data.aws_region.current.name
      DJANGO_CONFIGURATION               = "HerokuProductionConfiguration"
      DJANGO_ALLOWED_HOSTS               = local.fqdn
      DJANGO_CORS_ORIGIN_WHITELIST       = join(",", var.django_cors_origin_whitelist)
      DJANGO_CORS_ORIGIN_REGEX_WHITELIST = join(",", var.django_cors_origin_regex_whitelist)
      DJANGO_DEFAULT_FROM_EMAIL          = local.django_default_from_email
      DJANGO_STORAGE_BUCKET_NAME         = local.storage_bucket_name
    },
    # Pass var.additional_django_vars second, so it can override values
    var.additional_django_vars
  )
  sensitive_config_vars = merge(
    {
      AWS_SECRET_ACCESS_KEY = aws_iam_access_key.heroku_user.secret
      DJANGO_EMAIL_URL      = "submission://${urlencode(module.smtp.username)}:${urlencode(module.smtp.password)}@${module.smtp.host}:${module.smtp.port}"
      DJANGO_SECRET_KEY     = random_string.django_secret.result
    },
    # Pass var.additional_sensitive_django_vars second, so it can override values
    var.additional_sensitive_django_vars
  )

  web_dyno_size        = var.heroku_web_dyno_size
  web_dyno_quantity    = var.heroku_web_dyno_quantity
  worker_dyno_size     = var.heroku_worker_dyno_size
  worker_dyno_quantity = var.heroku_worker_dyno_quantity
  postgresql_plan      = var.heroku_postgresql_plan
  cloudamqp_plan       = var.heroku_cloudamqp_plan
}

resource "aws_route53_record" "heroku" {
  zone_id = var.route53_zone_id
  name    = var.subdomain_name
  type    = "CNAME"
  ttl     = "300"
  records = [module.heroku.cname]
}
