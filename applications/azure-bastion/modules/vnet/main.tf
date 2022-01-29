resource "azurerm_virtual_network" "bastionmgmtvnet" {
  name                = "${var.project}-vnet"
  address_space       = ["10.255.255.0/24"]
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_subnet" "azurebastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.bastionmgmtvnet.name
  address_prefixes     = ["10.255.255.0/25"]
}

resource "azurerm_subnet" "mgmtsubnet" {
  count = var.deploy_management ? 1 : 0

  name                 = "${var.project}-mgmtsubnet"
  resource_group_name  = var.resourcegroupname
  virtual_network_name = azurerm_virtual_network.bastionmgmtvnet.name
  address_prefixes     = ["10.255.255.128/25"]
}