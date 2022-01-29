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

module "vnet" {
  source = "./modules/vnet"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  deploy_management = var.deploy_management
}

module "bastion" {
  source = "./modules/bastion"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  bastionsubnetid   = module.vnet.azurebastionsubnet.id
}


module "managementvm" {
  source = "./modules/managementvm"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  mgmtsubnetId      = module.vnet.mgmtsubnet[0].id
  deploy_management = var.deploy_management
  mgmtvm            = var.mgmtvm
}

module "vnetpeerings" {
  source            = "./modules/vnet-peerings"
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  bastionmgmtvnet   = module.vnet.bastionmgmtvnet
}