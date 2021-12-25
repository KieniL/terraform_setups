output "instance_ip_addr" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "The Public IP address of the main server instance."
}