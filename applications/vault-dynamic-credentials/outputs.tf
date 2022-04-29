output "role_id" {
    value = vault_approle_auth_backend_role.jenkins_deployer.role_id
}

output "secret_id" {
    value = vault_approle_auth_backend_role_secret_id.jenkins_secret_id.secret_id
    sensitive = true
}