# terraform-heroku-django
A Terraform module to provision Django-Girder infrastructure on Heroku + AWS.

This provides a Heroku app, an IAM user, an S3 storage, and outgoing SMTP credentials.

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

## How to change database plans
This is a complex maintenance action, as it involves state across multiple services. Normally you use Terraform code as the only path to changing system infrastructure, but this is a notable exception.

There is state in the following:

 * data in the database
 * database URL in the Heroku app
 * database Heroku plan as managed by Terraform
 * database resource ID as managed by Terraform

To change the database plan, first change the plan in Heroku, and then update Terraform Cloud, and finally update the Terraform code.

### Change the Heroku Database Plan in Heroku

Follow the Heroku docs for the detailed process, which requires the use of the Heroku CLI. The high level workflow is:

1. Create a new database, with a new database alias URL
2. Copy data from the old to the new database
3. Attach the Heroku application to the new database
4. If the database transfer succeeded, you can delete the old database TODO: how does this interact with backups? i.e., delete old database also deletes backups or makes them unrecoverable?
5. After the transfer succeeds, as an additional cleanup step, delete the additional database alias, leaving the `DATABASE_URL` connection in place

### Update the state in Terraform Cloud

Note: Terraform Cloud always maintains custody of Terraform state, but Terraform Cloud has a remote and local mode which controls what client is interacting with that canonical state. Remote mode means interacting with Terraform cloud from an automated flow such as a CD action, and this is the default. Local mode means interacting with Terraform Cloud from the Terraform CLI.

After changing the Heroku database plan, Terraform Cloud needs to be informed of the change by the following workflow:

1. Change Terraform Cloud from Remote to Local mode
2. Using the Terraform CLI, delete the resource for the Heroku App Database TODO: what is the Terraform key for this resource? What are the commands?
3. Using the Heroku CLI, grab the id of the database resource attached to the Heroku App (this should be the updated database). TODO: What are the commands and keys?
4. Using the Terraform CLI, update the resource for the Heroku App Database to the id taken from the Heroku CLI
5. TODO: need to update the Terraform Heroku DB plan, or just the ID?
6. Run a `terraform plan` locally and see that no changes need to be made. This means that Terraform Cloud's understanding of your system's state is up to date with the changes that you manually performed on your Heroku App when you changed the database plan.
7. Change Terraform Cloud back from Local mode to Remote

### Update the Heroku Database Plan in Terraform code

Create a code update setting the Heroku database plan to the new plan, in the `api` module section of your Terraform code. This will be 
`heroku_postgresql_plan` as defined in `variables.tf` if using the `girder/django/heroku` module or else `postgresql_plan` if importing `girder/django/heroku//modules/heroku`.

When you create a PR with this code change, the Terraform Plan should show no changes need to be made.
