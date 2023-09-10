resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgname
  location            = var.location
  resource_group_name = var.resourcegroupname

  security_rule {
    name                       = "ALLOW_INCOMING_FROM_MY_IP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = [22]
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DISALLOW_INBOUND_VNET_COMMUNICATION"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range = "*"
    source_address_prefix = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "DISALLOW_OUTBOUND_VNET_COMMUNICATION"
    priority                   = 4096
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range = "*"
    source_address_prefix = "VirtualNetwork"
    destination_address_prefix = "*"
  }


  tags = var.tags
}
