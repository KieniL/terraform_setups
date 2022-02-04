output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "subnetexternal" {
  value = azurerm_subnet.subnetexternal
}

output "subnetinternal" {
  value = azurerm_subnet.subnetinternal
}


