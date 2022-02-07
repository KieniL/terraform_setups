/*
* # Fortiweb
*
* A terraform module which deploys Fortiweb with Terraform Modules based on these two documentations
* * [FortiwebDocumentationARM](https://docs.fortinet.com/document/fortiweb-public-cloud/latest/deploying-fortiweb-on-azure/403009/deploying-fortiweb-vm-from-arm-template)
* * [ARMTemplateForConversion](https://ftnt.blob.core.windows.net/fortiweb-bootstrap-template/azure_bootstrap.json?sv=2020-04-08&st=2022-01-06T01%3A40%3A00Z&se=2025-01-08T01%3A40%3A00Z&sr=b&sp=r&sig=0aRrMzy6zHwbeXQPAvRoE0wjBOnT2ejaeWEv99NrogI%3D)
* <br/><br/>
* The Marketplace terms needs to be accepted with: <code>az vm image terms accept --urn fortinet:fortinet_fortiweb-vm_v5:fortinet_fw-vm_payg:6.3.17</code>
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
  name     = "${var.project}-rg"
  location = var.location
  tags = {
    project   = var.project
    publisher = upper("${var.publisher}")
    provider  = upper("${var.providertag}")
  }
}

module "vnet" {
  source = "./modules/vnet"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.project
}

module "fortiwebvm" {
  source = "./modules/fortiwebvm"

  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  project           = var.project
  subnetexternal    = module.vnet.subnetexternal
  subnetinternal    = module.vnet.subnetinternal
  vmsize            = var.vmSku
  username          = var.adminUserName
  password          = var.adminPassword
  source_ip         = var.source_ip

  subnetexternalstartadress = module.vnet.subnetexternalstartadress

  subnetinternalstartadress = module.vnet.subnetinternalstartadress
}