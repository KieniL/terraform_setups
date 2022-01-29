provider "azurerm" {
  alias = "vnettest"
  features {}
}

data "azurerm_virtual_network" "vnetdest" {
  for_each            = { for i, v in var.vnet_peerings : i => v }
  provider            = azurerm.vnettest
  name                = each.value.name
  resource_group_name = each.value.resourcegroup
}

resource "azurerm_virtual_network_peering" "vnet-peering-source" {
  for_each                  = { for i, v in var.vnet_peerings : i => v }
  name                      = "To${each.value.name}"
  resource_group_name       = var.resourcegroupname
  virtual_network_name      = var.bastionmgmtvnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnetdest["${each.key}"].id
}

resource "azurerm_virtual_network_peering" "vnet-peering-dest" {
  for_each                  = { for i, v in var.vnet_peerings : i => v }
  provider                  = azurerm.vnettest
  name                      = "To${var.project}-vnet"
  resource_group_name       = each.value.resourcegroup
  virtual_network_name      = each.value.name
  remote_virtual_network_id = var.bastionmgmtvnet.id
}
