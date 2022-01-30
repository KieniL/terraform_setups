output "vnet" {
  value = azurerm_virtual_network.vnet
}


output "frontend" {
  value = azurerm_subnet.frontend
}

output "backend" {
  value = azurerm_subnet.backend
}