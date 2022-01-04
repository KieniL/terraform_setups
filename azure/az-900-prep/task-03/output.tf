output "containerinstance_url" {
  value       = "http://${azurerm_container_group.containerinstancegroup.fqdn}"
  description = "The URL on which to access the containerinstance."

  depends_on = [
    azurerm_container_group.containerinstancegroup
  ]
}