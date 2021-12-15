provider "vault" {
}

resource "vault_auth_backend" "aws" {
  type = "aws"

  tune {
    max_lease_ttl      = "90000s"
  }
}

resource "vault_policy" "aws-admin-policy" {
  name = "aws-admin"

  policy = <<EOT
path "aws/*" {
  capabilities = ["update","list","read","create"]
}
EOT
}
