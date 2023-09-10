output "subnetids" {
    description = "the subnetids"
    value = values(azurerm_subnet.subnet)[*].id
}

output "vnetid" {
    description = "the vnetid"
    value = azurerm_virtual_network.vnet.id
}