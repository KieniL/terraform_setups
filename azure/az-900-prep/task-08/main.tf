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
  name     = "${var.resource.prefix}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "functionsapptestsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.resource.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_app_service_plan" "appservice" {
  name                = "azure-functions-test-service-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.resource.location

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_function_app" "function" {
  name                       = "test-azure-functions"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.resource.location
  app_service_plan_id        = azurerm_app_service_plan.appservice.id
  storage_account_name       = azurerm_storage_account.storageaccount.name
  storage_account_access_key = azurerm_storage_account.storageaccount.primary_access_key

  tags = {
    project = var.resource.project
  }
}