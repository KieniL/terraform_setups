/*
* # dns deployment
* ![Diagram](./graph.svg)
*/

resource "azurerm_dns_zone" "akszone" {
  name                = var.domainname
  resource_group_name = var.resourcegroupname

  tags = var.tags
}