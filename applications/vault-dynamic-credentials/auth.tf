resource "vault_policy" "jenkins_deployer_policy" {
  name = "jenkins_deployer_policy"

  policy = <<EOT
path "aws/${vault_aws_secret_backend_role.admin_role.name}" {
  capabilities = ["read"]
}
EOT
}

resource "vault_auth_backend" "approle" {
  type = "approle"
}

resource "vault_approle_auth_backend_role" "jenkins_deployer" {
  backend                 = vault_auth_backend.approle.path
  role_name               = "jenkins_deployer"
  token_policies          = [vault_policy.jenkins_deployer_policy.name]
  secret_id_num_uses      = var.secret_id_uses
  secret_id_ttl           = var.secret_id_ttl
  secret_id_bound_cidrs   = var.secret_id_bound_ip_addresses
  token_bound_cidrs       = var.token_bound_ip_addresses
  token_no_default_policy = true
}

resource "vault_approle_auth_backend_role_secret_id" "jenkins_secret_id" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.jenkins_deployer.role_name
  cidr_list = var.secret_id_bound_ip_addresses
}

resource "vault_policy" "jenkins_auth_policy" {
  name = "jenkins_auth_policy"

  policy = <<EOT
# Create and manage roles
path "auth/approle/${vault_approle_auth_backend_role.jenkins_deployer.role_name}" {
  capabilities = [ "read", "update"]
}
EOT
}

resource "vault_token" "jenkins_init_token" {

  policies = [vault_policy.jenkins_auth_policy.name]

  renewable         = true
  ttl               = "5m"
  num_uses = 1
  no_default_policy = true

  renew_min_lease = 43200
  renew_increment = 86400
}