output "jenkins_token" {
  value     = vault_token.jenkins_init_token.client_token
  sensitive = true
}