output "loadbalancer_ip" {
  value = azurerm_public_ip.lbip.ip_address
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}