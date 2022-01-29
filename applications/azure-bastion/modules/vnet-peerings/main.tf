#each peering is defined manually since there could be multiple subscriptions 
#and it is not allowed to change the subscription other than through provider which does not allow loops

provider "azurerm" {
  alias = "vnettest"
  features {}
}

data "azurerm_virtual_network" "vnetdest-1" {
  provider            = azurerm.vnettest
  name                = "testvnet"
  resource_group_name = "test-rg"
}

resource "azurerm_virtual_network_peering" "vnet-peering-source-1" {
  name                      = "PeerWithtestvnet"
  resource_group_name       = var.resourcegroupname
  virtual_network_name      = var.bastionmgmtvnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnetdest-1.id
}

resource "azurerm_virtual_network_peering" "vnet-peering-dest-1" {
  provider                  = azurerm.vnettest
  name                      = "PeerWith${var.project}-vnet"
  resource_group_name       = "test-rg"
  
  virtual_network_name      = "testvnet"
  remote_virtual_network_id = var.bastionmgmtvnet.id
}
