/*
* # aks deployment
* ![Diagram](./graph.svg)
*/

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resourcegroupname
  dns_prefix          = var.prefix

  default_node_pool {
    name           = "default"
    node_count     = var.default_node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "akspool" {
  name                  = "${var.prefix}pool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.vm_size
  vnet_subnet_id        = var.subnet_id
  node_count            = var.spot_node_count
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = -1 # note: the maximum price to pay is the on demand price
  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
  }
  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule"
  ]
  tags = var.tags

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags since there is an API error 
      tags,
    ]
  }
}