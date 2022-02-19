/*
* # vnet deployment
* ![Diagram](./graph.svg)
*/

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = var.resourcegroupname
  address_space       = ["10.1.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = ["10.1.0.0/20"]
}

resource "azurerm_subnet" "appgw" {
  name                 = "appgw"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = ["10.1.16.0/20"]
}

resource "azurerm_route_table" "podroutetable" {
  name                          = "pod-route-table"
  location                      = var.location
  resource_group_name           = var.resourcegroupname
  disable_bgp_route_propagation = false

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "podnoderouteassoc" {
  subnet_id      = azurerm_subnet.internal.id
  route_table_id = azurerm_route_table.podroutetable.id
}

resource "azurerm_subnet_route_table_association" "podappgwrouteassoc" {
  subnet_id      = azurerm_subnet.appgw.id
  route_table_id = azurerm_route_table.podroutetable.id
}