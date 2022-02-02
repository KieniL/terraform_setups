resource "azurerm_logic_app_standard" "appstandard" {
  name                       = "${var.project}-logicapp-workflow"
  location                   = var.location
  resource_group_name        = var.resourcegroupname
  app_service_plan_id        = var.appserviceplan.id
  storage_account_name       = var.storageaccount.name
  storage_account_access_key = var.storageaccount.primary_access_key
}