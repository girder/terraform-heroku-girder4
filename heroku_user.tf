resource "aws_iam_user" "heroku_user" {
  name = "${var.project_slug}-heroku"
}

resource "aws_iam_access_key" "heroku_user" {
  user = aws_iam_user.heroku_user.name
}

resource "aws_iam_user_policy" "heroku_user_storage" {
  user   = aws_iam_user.heroku_user.id
  name   = "${var.project_slug}-storage"
  policy = module.storage.django_policy
}
