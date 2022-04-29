output "token" {
  value     = vault_token.jenkins_deployer_token.client_token
  sensitive = true
}