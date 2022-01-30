output "gateway_ip" {
  value = azurerm_public_ip.gatewayip.ip_address
}

output "appgateway" {
  value = azurerm_application_gateway.appgateway
}