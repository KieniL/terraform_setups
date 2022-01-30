terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.94.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource.prefix}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}


module "vnet" {
  source = "./modules/vnet"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
}


module "scaleset" {
  source = "./modules/scaleset"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  subnet            = module.vnet.backend
  vm                = var.vm
  appgateway        = module.appgateway.appgateway
}

module "monitoring" {
  source = "./modules/monitoring"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  scaleset          = module.scaleset.scaleset
  appgateway        = module.appgateway.appgateway
}


module "appgateway" {
  source = "./modules/appgateway"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  frontend          = module.vnet.frontend
}
