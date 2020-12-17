resource "aws_iam_instance_profile" "default" {
  count = 1
  name  = module.this.id
  role  = aws_iam_role.default[0].name
}

resource "aws_iam_role" "default" {
  count = 1
  name  = module.this.id
  path  = "/"

  assume_role_policy = data.aws_iam_policy_document.default.json
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}
