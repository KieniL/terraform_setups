resource "azurerm_app_service_plan" "logicappserviceplan" {
  name                = "${var.project}-logicapp-service-plan"
  location            = var.location
  resource_group_name = var.resourcegroupname

  sku {
    tier = "WorkflowStandard"
    size = "WS1"
  }

  tags = var.tags
}