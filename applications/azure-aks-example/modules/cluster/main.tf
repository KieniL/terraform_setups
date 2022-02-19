/*
* # aks deployment
* ![Diagram](./graph.svg)
*/

resource "azurerm_user_assigned_identity" "aksuseridentity" {
  name                = "${var.prefix}-aks-identity"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_role_definition" "aksroutetablerole" {
  name        = "${var.prefix}-aks-role"
  scope       = var.customroutetable_id
  description = "This is a custom role to read and write to routetable"

  permissions {
    actions     = ["Microsoft.Network/routeTables/read", "Microsoft.Network/routeTables/write"]
    not_actions = []
  }

  assignable_scopes = [
    var.customroutetable_id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}

resource "azurerm_role_assignment" "aksroleassigments" {
  scope                = var.customroutetable_id
  role_definition_name = azurerm_role_definition.aksroutetablerole.name
  principal_id         = azurerm_user_assigned_identity.aksuseridentity.principal_id
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = var.location
  resource_group_name = var.resourcegroupname
  dns_prefix          = var.prefix


  auto_scaler_profile {
    balance_similar_node_groups = true
  }
  api_server_authorized_ip_ranges = [var.source_ip]

  default_node_pool {
    name                = "default"
    min_count           = var.default_min_node_count
    max_count           = var.default_max_node_count
    vm_size             = var.default_vm_size
    vnet_subnet_id      = var.internal_subnet_id
    enable_auto_scaling = true
  }

  identity {
    type                      = "UserAssigned"
    user_assigned_identity_id = azurerm_user_assigned_identity.aksuseridentity.id
  }

  addon_profile {
    ingress_application_gateway {
      enabled   = true
      subnet_id = var.appgw_subnet_id
    }
  }


  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "akspool" {
  for_each              = toset(var.spot_vm_sizes)
  name                  = "${var.prefix}pool${index(var.spot_vm_sizes, each.key)}"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = each.value
  vnet_subnet_id        = var.internal_subnet_id
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