/*
* # AKS example
*
* AKS deployment with terraform and following example applications: <br/>
* * AWX
*/

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = {
    project = var.project
  }
}

module "vnet" {
  source            = "./modules/vnet"
  prefix            = var.prefix
  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
}


module "cluster" {
  source            = "./modules/cluster"
  prefix            = var.prefix
  tags              = azurerm_resource_group.rg.tags
  location          = azurerm_resource_group.rg.location
  resourcegroupname = azurerm_resource_group.rg.name
  subnet_id         = module.vnet.subnet_id
}

resource "local_file" "kubeconfig" {
  content  = module.cluster.kube_config
  filename = "aksconfig"
}


module "awx" {
  source      = "./modules/cluster-workloads-awx"
  awx_version = var.awx_version
  # prefix            = var.prefix
  # tags              = azurerm_resource_group.rg.tags
  # location          = azurerm_resource_group.rg.location
  # resourcegroupname = azurerm_resource_group.rg.name
  # subnet_id         = module.vnet.subnet_id
}