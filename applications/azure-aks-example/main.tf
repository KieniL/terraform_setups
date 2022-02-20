/*
* # AKS example
*
* AKS deployment with terraform and following example applications: <br/>
* * AWX
* * Vault
* <br/>
* To have network segmentations there are different pod_subnets which makes it necessary to enable a previewfeature:<br/>
* <code>az feature register --namespace "Microsoft.ContainerService" --name "PodSubnetPreview"</code><br/>
* <code>az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSubnetPreview')].{Name:name,State:properties.state}"</code>
* see [MicrosoftDoc](https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni#register-the-podsubnetpreview-preview-feature) <br/>
* The cluster itself runs on an Standard_B2s size and has multiple nodepools with different sizes and spot instances
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
  spot_vm_sizes          = var.spot_vm_sizes
  default_min_node_count = var.default_min_node_count
  default_max_node_count = var.default_max_node_count
  spot_min_node_count    = var.spot_min_node_count
  spot_max_node_count    = var.spot_max_node_count
  source_ip              = var.source_ip
  dns_zone_id            = module.dns.zone_id
}

module "awx" {
  source                 = "./modules/cluster-workloads-awx"
  awx_version            = var.awx_version
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = base64decode(module.cluster.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.cluster.kube_config.client_certificate)
  client_key             = base64decode(module.cluster.kube_config.client_key)
  awx_namespace          = var.awx_namespace
  domainname             = var.domainname
}

module "vault" {
  source                 = "./modules/cluster-workloads-vault"
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = base64decode(module.cluster.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.cluster.kube_config.client_certificate)
  client_key             = base64decode(module.cluster.kube_config.client_key)
  vault_namespace        = var.vault_namespace
}

module "dns" {
  source            = "./modules/dns"
  tags              = azurerm_resource_group.rg.tags
  resourcegroupname = azurerm_resource_group.rg.name
  domainname        = var.domainname
}

module "external-dns" {
  source                 = "./modules/cluster-workloads-external-dns"
  kubernetes_host        = module.cluster.kube_config.host
  cluster_token          = module.cluster.kube_config.password
  cluster_ca_certificate = base64decode(module.cluster.kube_config.cluster_ca_certificate)
  client_certificate     = base64decode(module.cluster.kube_config.client_certificate)
  client_key             = base64decode(module.cluster.kube_config.client_key)
  dns_namespace          = var.dns_namespace
  resourcegroupname      = azurerm_resource_group.rg.name
  domainname             = var.domainname
  gateway_client_id      = module.cluster.gateway_client_id
}