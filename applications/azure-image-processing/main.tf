terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
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

resource "azurerm_storage_account" "storageaccount" {
  name                     = "${var.resource.project}-storageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = azurerm_resource_group.rg.tagss
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "${var.resource.project}-storageaccountcontainer"
  storage_account_name  = azurerm_storage_account.storageaccount.name
  container_access_type = "private"

}