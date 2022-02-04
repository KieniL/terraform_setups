resource "azurerm_network_interface" "externalnic" {
  name                          = "${var.project}-externalnic"
  location                      = var.location
  resource_group_name           = var.resourcegroupname
  enable_accelerated_networking = false
  enable_ip_forwarding          = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnetexternal.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }

  ip_configuration {
    name                          = "VirtualIP"
    subnet_id                     = var.subnetexternal.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    primary                       = false
  }
}

resource "azurerm_network_security_group" "fortinsg" {
  name                = "${var.project}-fortinsg"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "externalnic_fortinsg_ass" {
  network_interface_id      = azurerm_network_interface.externalnic.id
  network_security_group_id = azurerm_network_security_group.fortinsg.id
}