output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "subnetexternal" {
  value = azurerm_subnet.subnetexternal
}

output "subnetinternal" {
  value = azurerm_subnet.subnetinternal
}

output "subnetexternalstartadress" {
  value = "10.0.1.4"
}

output "subnetinternalstartadress" {
  value = "10.0.2.4"
}
