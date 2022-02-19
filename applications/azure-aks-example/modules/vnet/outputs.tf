output "internal_subnet_id" {
  value = azurerm_subnet.internal.id
}

output "appgw_subnet_id" {
  value = azurerm_subnet.appgw.id
}