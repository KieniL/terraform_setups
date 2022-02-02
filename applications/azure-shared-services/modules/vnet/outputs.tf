output "azurebastionsubnet" {
  value = azurerm_subnet.azurebastionsubnet
}

output "mgmtsubnet" {
  value = azurerm_subnet.mgmtsubnet
}

output "bastionmgmtvnet" {
  value = azurerm_virtual_network.bastionmgmtvnet
}
