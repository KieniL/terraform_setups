provider "vault" {
}

resource "vault_policy" "aws-admin-policy" {
  name = "aws-admin"

  policy = <<EOT
path "aws/*" {
  capabilities = ["update","list","read","create"]
}
EOT
}

resource "vault_aws_secret_backend" "aws" {
  access_key = var.accesskey
  secret_key = var.secretkey

}

resource "vault_aws_secret_backend_role" "role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "deploy"
  credential_type = "iam_user"

  policy_document = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
  ]
}
EOT
}

