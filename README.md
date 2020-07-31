# terraform-heroku-django
A Terraform module to provision Django-Girder infrastructure on Heroku + AWS.

This provides a Heroku app, an IAM user, an S3 storage, and outgoing SMTP credentials.

## Note on AWS Email Sending
[Every AWS account must explicitly apply to send real emails](https://docs.aws.amazon.com/ses/latest/DeveloperGuide/request-production-access.html),
once per Simple Email Service (SES) region.

Approvals seem to be granted liberally and to take about 24 hours.
