output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0

  sensitive = true
}

output "gateway_client_id" {
  value = azurerm_kubernetes_cluster.aks.addon_profile.0.ingress_application_gateway.0.ingress_application_gateway_identity.0.client_id
}