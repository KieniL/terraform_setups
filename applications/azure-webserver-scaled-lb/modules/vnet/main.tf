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