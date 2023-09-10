output "nsgid" {
    description = "the id of the created nsg"
    value = azurerm_network_security_group.nsg.id
}