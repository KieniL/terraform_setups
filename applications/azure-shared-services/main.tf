/**
  * # README.md
  *
  * This is the readme of the example repository for terraform-docs poc.
  */

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
  source            = "./modules/managementvm"
  count             = var.deploy_management ? 1 : 0
  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.resource.project
  mgmtsubnetId      = module.vnet.mgmtsubnet[0].id
  deploy_management = var.deploy_management
  mgmtvm            = var.mgmtvm
}

module "vnetpeerings" {
  source               = "./modules/vnet-peerings"
  resourcegroupname    = azurerm_resource_group.rg.name
  project              = var.resource.project
  bastionmgmtvnet      = module.vnet.bastionmgmtvnet
  remote_resourcegroup = var.remote_resourcegroup
  remote_vnet          = var.remote_vnet
}

/**
 * # Footer
 *
 * Everything in this comment block will get extracted.
 *
 * You can put simple text or complete Markdown content
 * here. Subsequently if you want to render AsciiDoc format
 * you can put AsciiDoc compatible content in this comment
 * block.
 */