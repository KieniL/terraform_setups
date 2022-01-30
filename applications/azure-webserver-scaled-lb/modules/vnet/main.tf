resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_subnet" "frontend" {
  name                 = "${var.project}-frontendsubnet"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "${var.project}-backendsubnet"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "frontendnsg" {
  name                = "${var.project}-frontendsubnet-nsg"
  location            = var.location
  resource_group_name = var.resourcegroupname


  security_rule {
    name                       = "ALLOW_INCOMING_FROM_MY_IP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = [80, 443]
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALLOW_APPGATEWAY_PROBE"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = ["65200-65535"]
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "backendnsg" {
  name                = "${var.project}-backendsubnet-nsg"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "frontend_nsg_assoc" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.frontendnsg.id
}

resource "azurerm_subnet_network_security_group_association" "backend_nsg_assoc" {
  subnet_id                 = azurerm_subnet.backend.id
  network_security_group_id = azurerm_network_security_group.backendnsg.id
}