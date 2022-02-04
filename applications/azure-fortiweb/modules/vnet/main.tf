resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = vazurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "subnet1" {
  name                 = "${var.project}-subnet1"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "${var.project}-subnet1"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

