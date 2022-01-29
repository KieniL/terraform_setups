output "gateway_ip" {
  value = azurerm_public_ip.gatewayip.ip_address
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}