resource "vault_azure_secret_backend" "azure" {
  use_microsoft_graph_api = true
  subscription_id         = var.azure_subscription_id
  tenant_id               = var.azure_tenant_id
  client_id               = var.azure_client_id
  client_secret           = var.azure_client_secret
  environment             = var.azure_environment
}

resource "vault_azure_secret_backend_role" "storage_manager_role" {
  backend = vault_azure_secret_backend.azure.path
  role    = "storage_manager_role"
  ttl     = var.aws_default_role_lease_seconds
  max_ttl = var.aws_max_role_lease_seconds

  azure_roles {
    role_name = "Reader"
    scope     = "/subscriptions/${var.azure_subscription_id}/resourceGroups/${var.azure_showcasing_resourcegroup}"
  }
}

resource "vault_mount" "kvv2" {
  path        = "secret"
  type        = "kv-v2"
  description = "This is a kv secret for azure data"
}

resource "vault_generic_secret" "azure_data" {
  path = "secret/azure_data"
  depends_on = [
    vault_mount.kvv2
  ]

  data_json = <<EOT
{
  "subscription_id":   "${var.azure_subscription_id}",
  "tenant_id": "${var.azure_tenant_id}"
}
EOT
}