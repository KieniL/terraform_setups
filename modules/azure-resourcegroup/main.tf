resource "azurerm_resource_group" "rg" {
  name     = var.resourcegroup_name
  location = var.location

  tags = var.tags
}


resource "azurerm_role_assignment" "role_assignment" {
  count = var.role_definition_name != null && var.principal_id != null ? 1 : 0
  scope                = azurerm_resource_group.rg.id
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}