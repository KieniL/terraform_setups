/*
* # aks deployment
* ![Diagram](./graph.svg)
*/

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resourcegroupname
  dns_prefix          = var.prefix

  auto_scaler_profile {
    balance_similar_node_groups = true
  }

  default_node_pool {
    name                = "default"
    node_count          = var.default_min_node_count
    max_count           = var.default_max_node_count
    vm_size             = var.default_vm_size
    vnet_subnet_id      = var.subnet_id
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "akspool" {
  name                  = "${var.prefix}pool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = var.spot_vm_size
  vnet_subnet_id        = var.subnet_id
  min_count             = var.spot_min_node_count
  max_count             = var.spot_max_node_count
  priority              = "Spot"
  eviction_policy       = "Delete"
  spot_max_price        = -1 # note: the maximum price to pay is the on demand price
  enable_auto_scaling   = true
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