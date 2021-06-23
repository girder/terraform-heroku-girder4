# terraform-heroku-django
A Terraform module to provision Django-Girder infrastructure on Heroku + AWS.

This provides a Heroku app, an IAM user, an S3 storage, and outgoing SMTP credentials.

See [full usage documentation at Terraform Registry](https://registry.terraform.io/modules/girder/django/heroku/latest).

## Note on AWS Email Sending
[Every AWS account must explicitly apply to send real emails](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html),
once per Simple Email Service (SES) region.

Approvals seem to be granted liberally and to take about 24 hours.

## Note on initial creation of Heroku apps
When first creating an instance of this module, provisioning of the Heroku app
(specifically the `heroku_formation` resources) will likely fail with a
"Couldn't find that process type" error message. To resolve this, the Heroku app
code must be deployed at least once.

Typically, this can be done by
[connecting a GitHub repo to the Heroku app](https://devcenter.heroku.com/articles/github-integration#enabling-github-integration)
and then
[triggering a manual deploy](https://devcenter.heroku.com/articles/github-integration#manual-deploys).
Finally, run `terraform apply` again, which should succeed.

Afterwards, it's advisable to also
[set up automatic deploys](https://devcenter.heroku.com/articles/github-integration#automatic-deploys).
