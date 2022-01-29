resource "azurerm_public_ip" "bastionip" {
  name                = "${var.project}-bastionip"
  location            = var.location
  resource_group_name = var.resourcegroupname
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = "${var.project}-bastion"
  location            = var.location
  resource_group_name = var.resourcegroupname

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = var.bastionsubnetid
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }

  tags = var.tags
}