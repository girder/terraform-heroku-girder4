# terraform-heroku-girder4
A Terraform module to provision Girder4 infrastructure on Heroku + AWS.

This facilitates deployment of Django applications created from the
[Girder4 cookiecutter](https://github.com/girder/cookiecutter-girder-4).
It creates a Heroku app with addons for
[PostgreSQL](https://elements.heroku.com/addons/heroku-postgresql),
[CloudAMQP](https://elements.heroku.com/addons/cloudamqp),
and [Papertrail](https://elements.heroku.com/addons/papertrail).
It also creates
[AWS S3](https://aws.amazon.com/s3/) storage,
[outgoing SMTP](https://aws.amazon.com/ses/) credentials,
and an optional [AWS EC2](https://aws.amazon.com/ec2/) worker.

See [full usage documentation at Terraform Registry](https://registry.terraform.io/modules/girder/girder4/heroku).

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
