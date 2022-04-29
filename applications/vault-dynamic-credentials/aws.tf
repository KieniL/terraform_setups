resource "vault_aws_secret_backend" "aws" {
  access_key                = var.aws_accesskey
  secret_key                = var.aws_secretkey
  default_lease_ttl_seconds = var.aws_default_role_lease_seconds
  max_lease_ttl_seconds     = var.aws_max_role_lease_seconds
}

resource "vault_aws_secret_backend_role" "iam_manager_role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "iam_manager_role"
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

resource "vault_aws_secret_backend_role" "audit_role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "audit_role"
  credential_type = "iam_user"
  policy_arns     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}


resource "vault_aws_secret_backend_role" "developer_role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "developer_role"
  credential_type = "iam_user"
  policy_document = <<EOT
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "StringEquals": {
                    "aws:ResourceTag/Owner": "devTeam"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeInstances",
            "Resource": "*"
        }
    ]
}
EOT
}


resource "vault_aws_secret_backend_role" "storage_manager_role" {
  backend         = vault_aws_secret_backend.aws.path
  name            = "storage_manager_role"
  credential_type = "iam_user"
  policy_document = <<EOT
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Action": "s3:ListAllMyBuckets",
         "Resource":"*"
      }
   ]
}
EOT
}