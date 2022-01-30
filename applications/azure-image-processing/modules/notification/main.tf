resource "azurerm_eventgrid_topic" "processingtopic" {
  name                = "${var.project}-imgprocessing-topic"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}