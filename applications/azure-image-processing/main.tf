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
  name     = "${var.resource.project}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}


module "imgstorageaccount" {
  source = "./modules/storageaccount"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
}

module "imgfunction" {
  source = "./modules/function"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  storageaccount    = module.imgstorageaccount.storageaccount
}

module "imgnotification" {
  source = "./modules/notification"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
}

module "imglocicappcomponents" {
  source = "./modules/logicapps-components"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
}

module "imglocicappstandard" {
  source = "./modules/logicapp-standard"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  appserviceplan    = module.imglocicappcomponents.appserviceplan
  storageaccount    = module.imgstorageaccount.storageaccount
}