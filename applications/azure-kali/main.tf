module "vnet_resourcegroup" {
  source             = "../../modules/azure-resourcegroup"
  location           = var.location
  resourcegroup_name = var.vnet_resourcegroup_name
  tags               = var.tags
}

module "vnet" {
  source            = "../../modules/azure-vnet"
  location          = var.location
  resourcegroupname = var.vnet_resourcegroup_name
  vnet_cidr         = "10.1.0.0/16"
  vnet_name         = "Default-VNET"
  subnets = [{
    subnet_name = "Subnet-A"
    subnet_cidr = "10.1.0.0/19"
    }, {
    subnet_name = "Subnet-B"
    subnet_cidr = "10.1.32.0/19"
  }]
  tags       = var.tags
  depends_on = [module.vnet_resourcegroup.resourcegroupname]
}

module "nsg" {
  source            = "../../modules/azure-nsg"
  location          = var.location
  resourcegroupname = var.vnet_resourcegroup_name
  source_ip         = var.source_ip
  nsgname           = "kali-nsg"
  tags              = var.tags
  depends_on        = [module.vnet_resourcegroup.resourcegroupname]
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each = toset( module.vnet.subnetids)
  subnet_id                 = each.key
  network_security_group_id = module.nsg.nsgid
}

module "developer_resourcegroup" {
  for_each             = { for rg in var.developer_resourcegroup : rg.name => rg }
  source               = "../../modules/azure-resourcegroup"
  location             = var.location
  resourcegroup_name   = "${each.value.name}-rg"
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = each.value.principal_id
  tags = {
    project = "kali-${each.value.name}"
  }
}

resource "azurerm_role_assignment" "vnet_role_assignment" {
  for_each             = { for rg in var.developer_resourcegroup : rg.name => rg }
  scope                = module.vnet.vnetid
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = each.value.principal_id
}

resource "azurerm_role_assignment" "nsg_role_assignment" {
  for_each             = { for rg in var.developer_resourcegroup : rg.name => rg }
  scope                = module.nsg.nsgid
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = each.value.principal_id
}