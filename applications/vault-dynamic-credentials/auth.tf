resource "vault_policy" "jenkins_deployer_policy" {
  name = "jenkins_deployer_policy"

  policy = <<EOT
path "aws/creds/*" {
  capabilities = ["read"]
}
EOT
}

resource "vault_token" "jenkins_deployer_token" {

  policies          = [vault_policy.jenkins_deployer_policy.name]
  no_default_policy = true

  renewable = true
  ttl       = "100m"

  renew_min_lease = 43200
  renew_increment = 86400
}