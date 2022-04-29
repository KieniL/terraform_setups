# resource "vault_azure_secret_backend" "azure" {
#   use_microsoft_graph_api = true
#   subscription_id         = var.azure_subscription_id
#   tenant_id               = var.azure_tenant_id
#   client_id               = var.azure_client_id
#   client_secret           = var.azure_client_secret
#   environment             = var.azure_environment
# }