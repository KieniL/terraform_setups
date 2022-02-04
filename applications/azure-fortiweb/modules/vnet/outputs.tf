output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "subnet1" {
  value = azurerm_subnet.azurebastionsubnet
}

output "subnet2" {
  value = azurerm_subnet.mgmtsubnet
}


