/*
* # ARMTemplate
*
* A terraform module which runs an arm template inside of terraform to deploy fortiweb
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

  provisioner "local-exec" {
    command = <<EOT
    az group deployment create \
    --name ${var.resource.project}-Fortiweb \
    --resource-group ${azurerm_resource_group.rg.name} \
    --template-uri ${var.resource.templateuri}  \
    --parameters file("${path.module}/parameters.json")
  EOT
  }
}

