#each peering is defined manually since there could be multiple subscriptions 
#and it is not allowed to change the subscription other than through provider which does not allow loops




#everything between this block needs to be duplicated (provider only if there is another subscription involved)
#Block start 
# provider "azurerm" {
#   alias = "vnettest"
#   features {}
# }

# data "azurerm_virtual_network" "vnetdest" {
#   provider            = azurerm.PROVIDER_NAME
#   name                = TARGET_VNETNAME
#   resource_group_name = TARGET_RESOURCEGROUP
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-source-1" {
#   name                      = "PeerWithtestvnet"
#   resource_group_name       = var.resourcegroupname
#   virtual_network_name      = var.bastionmgmtvnet.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vnetdest.id
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-dest-1" {
#   provider                  = azurerm.vnettest
#   name                      = "PeerWith${var.project}-vnethub"
#   resource_group_name       = TARGET_RESOURCEGROUP

#   virtual_network_name      = TARGET_VNETNAME
#   remote_virtual_network_id = var.bastionmgmtvnet.id
# }
#Block End




# data "azurerm_virtual_network" "vnetdest-1" {
#   name                = "testvnet"
#   resource_group_name = "test-rg"
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-source-1" {
#   name                      = "PeerWithtestvnet"
#   resource_group_name       = var.resourcegroupname
#   virtual_network_name      = var.bastionmgmtvnet.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vnetdest-1.id
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-dest-1" {
#   name                      = "PeerWith${var.project}-vnethub"
#   resource_group_name       = "test-rg"

#   virtual_network_name      = "testvnet"
#   remote_virtual_network_id = var.bastionmgmtvnet.id
# }




# data "azurerm_virtual_network" "vnetdest-2" {
#   name                = "scaled-webserver-network"
#   resource_group_name = "webserver-rg"
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-source-2" {
#   name                      = "PeerWithscaled-webserver-network"
#   resource_group_name       = var.resourcegroupname
#   virtual_network_name      = var.bastionmgmtvnet.name
#   remote_virtual_network_id = data.azurerm_virtual_network.vnetdest-2.id
# }

# resource "azurerm_virtual_network_peering" "vnet-peering-dest-2" {
#   name                = "PeerWith${var.project}-vnet"
#   resource_group_name = "webserver-rg"

#   virtual_network_name      = "scaled-webserver-network"
#   remote_virtual_network_id = var.bastionmgmtvnet.id
# }
