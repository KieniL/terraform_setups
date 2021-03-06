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
  address_prefixes     = ["10.1.0.0/19"]
}

resource "azurerm_subnet" "appgw" {
  name                 = "appgw"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = ["10.1.32.0/19"]
}

resource "azurerm_subnet" "defaultpod" {
  name                 = "defaultpod"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = ["10.1.64.0/19"]

  delegation {
    name = "aks-delegation"

    service_delegation {
      name    = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "nodepoolpod" {
  name                 = "nodepoolpod"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resourcegroupname
  address_prefixes     = ["10.1.96.0/19"]

  delegation {
    name = "aks-delegation"

    service_delegation {
      name    = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
