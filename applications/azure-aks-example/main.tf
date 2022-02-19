/*
* # AKS example
*
* AKS deployment with terraform and following example applications: <br/>
* * AWX
* * Vault
*<br/>
* To have network segmentations there are different pod_subnets which makes it necessary to enable a previewfeature:<br/>
* <code>az feature register --namespace "Microsoft.ContainerService" --name "PodSubnetPreview"</code><br/>
* <code>az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSubnetPreview')].{Name:name,State:properties.state}"</code>
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
  source                 = "./modules/cluster"
  prefix                 = var.prefix
  tags                   = azurerm_resource_group.rg.tags
  location               = azurerm_resource_group.rg.location
  resourcegroupname      = azurerm_resource_group.rg.name
  internal_subnet_id     = module.vnet.internal_subnet_id
  appgw_subnet_id        = module.vnet.appgw_subnet_id
  default_pod_subnet_id  = module.vnet.default_pod_subnet_id
  nodepool_pod_subnet_id = module.vnet.nodepool_pod_subnet_id
  default_vm_size        = var.default_vm_size
  spot_vm_size           = var.spot_vm_size
  default_min_node_count = var.default_min_node_count
  default_max_node_count = var.default_max_node_count
  spot_min_node_count    = var.spot_min_node_count
  spot_max_node_count    = var.spot_max_node_count
  source_ip              = var.source_ip
}

module "awx" {
  source                 = "./modules/cluster-workloads-awx"
  awx_version            = var.awx_version
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = base64decode(module.cluster.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.cluster.kube_config.client_certificate)
  client_key             = base64decode(module.cluster.kube_config.client_key)
}

module "vault" {
  source                 = "./modules/cluster-workloads-vault"
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = base64decode(module.cluster.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.cluster.kube_config.client_certificate)
  client_key             = base64decode(module.cluster.kube_config.client_key)
}