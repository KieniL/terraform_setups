resource "azurerm_app_service_plan" "functionappservice" {
  name                = "${var.project}-imgfunctionappservice"
  location            = var.location
  resource_group_name = var.resourcegroupname
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = var.tags
}

resource "azurerm_function_app" "imagefunction" {
  name                       = "${var.project}-imgfunction"
  location                   = var.location
  resource_group_name        = var.resourcegroupname
  app_service_plan_id        = azurerm_app_service_plan.functionappservice.id
  storage_account_name       = var.storageaccount.name
  storage_account_access_key = var.storageaccount.primary_access_key
  tags                       = var.tags
}