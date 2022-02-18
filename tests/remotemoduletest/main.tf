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
  name     = "test-rg"
  location = var.location

  tags = {
    project = var.project
  }
}


module "vnet" {
    source = "git::https://github.com/KieniL/terraform_setups.git//applications//azure-webserver-scaled-lb//modules//vnet"
    source_ip = "0.0.0.0"
    tags = azurerm_resource_group.rg.tags
    project = var.project
    location = azurerm_resource_group.rg.location
    resourcegroupname = azurerm_resource_group.rg.name
}