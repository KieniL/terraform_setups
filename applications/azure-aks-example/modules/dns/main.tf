resource "azurerm_dns_zone" "example-public" {
  name                = var.domainname
  resource_group_name = var.resourcegroupname

  tags = var.tags
}