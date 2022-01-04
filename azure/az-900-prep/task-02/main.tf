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

resource "azurerm_app_service_plan" "service_plan" {
  name                = "${var.resource.prefix}-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_app_service" "appservice" {
  name                = "${var.resource.prefix}-appservice"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.service_plan.id
  https_only          = true

  client_affinity_enabled = false
  site_config {
    scm_type      = "VSTSRM"
    always_on     = "true"
    http2_enabled = true

    linux_fx_version = "DOCKER|mcr.microsoft.com/azuredocs/aci-helloworld" #define the images to usecfor you application

  }

  auth_settings {
    enabled = false
  }

  tags = {
    project = var.resource.project
  }
}