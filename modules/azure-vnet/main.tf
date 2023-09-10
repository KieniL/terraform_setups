resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resourcegroupname
  address_space       = [var.vnet_cidr]

  tags = var.tags
}

resource "azurerm_subnet" "subnet" {
  for_each             = { for s in var.subnets : s.subnet_name => s }
  name                 = each.value.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = [each.value.subnet_cidr]
}