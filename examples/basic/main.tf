provider "aws" {
  region = "us-east-1"
}
provider "heroku" {}

data "aws_route53_zone" "domain" {
  # This must be created by hand in the AWS console
  zone_id = "Z123456789"
}

data "heroku_team" "heroku" {
  # This must be created by hand in the Heroku console
  name = "heroku_team"
}

# This provides a zero-configuration option for assigning names,
# but most projects will want to select a more specific name instead
resource "random_pet" "instance_name" {
  prefix    = "girder"
  length    = 2
  separator = "-"
}

module "django" {
  source  = "girder/django/heroku"
  version = "0.5.0"

  project_slug     = random_pet.instance_name.id
  route53_zone_id  = data.aws_route53_zone.domain.zone_id
  heroku_team_name = data.heroku_team.heroku.name
  subdomain_name   = random_pet.instance_name.id
}

output "heroku_app_id" {
  value = module.django.heroku_app_id
}
output "iam_user_id" {
  value = module.django.iam_user_id
}
output "storage_bucket_name" {
  value = module.django.storage_bucket_name
}
