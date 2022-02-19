output "internal_subnet_id" {
  value = azurerm_subnet.internal.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}

output "default_pod_subnet_id" {
  value = azurerm_subnet.defaultpod.id
}

output "nodepool_pod_subnet_id" {
  value = azurerm_subnet.nodepoolpod.id
}