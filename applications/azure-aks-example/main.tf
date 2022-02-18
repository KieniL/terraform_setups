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
  source             = "./modules/cluster"
  prefix             = var.prefix
  tags               = azurerm_resource_group.rg.tags
  location           = azurerm_resource_group.rg.location
  resourcegroupname  = azurerm_resource_group.rg.name
  subnet_id          = module.vnet.subnet_id
  vm_size            = var.vm_size
  default_node_count = var.default_node_count
  spot_node_count    = var.spot_node_count
}

module "awx" {
  source                 = "./modules/cluster-workloads-awx"
  awx_version            = var.awx_version
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = module.cluster.kube_config.cluster_ca_certificate
  client_certificate     = module.cluster.kube_config.client_certificate
  client_key             = module.cluster.kube_config.client_key
}