terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.94.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource.project}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}

resource "azurerm_virtual_network" "bastionmgmtvnet" {
  name                = "${var.resource.project}-vnet"
  address_space       = ["10.255.255.0/24"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "azurebastionsubnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.bastionmgmtvnet.name
  address_prefixes     = ["10.255.255.0/25"]
}

resource "azurerm_subnet" "mgmtsubnet" {
  count = var.deploy_management ? 1 : 0

  name                 = "${var.resource.project}-mgmtsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.bastionmgmtvnet.name
  address_prefixes     = ["10.255.255.128/25"]
}

resource "azurerm_public_ip" "bastionip" {
  name                = "${var.resource.project}-bastionip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_bastion_host" "bastionhost" {
  name                = "${var.resource.project}-bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "ipconfig"
    subnet_id            = azurerm_subnet.azurebastionsubnet.id
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }

  tags = azurerm_resource_group.rg.tags
}


resource "azurerm_network_interface" "mgmtnic" {
  count               = var.deploy_management ? 1 : 0
  name                = "${var.resource.project}-mgmtnic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name      = "${var.resource.project}-mgmtnic-conf"
    subnet_id = azurerm_subnet.mgmtsubnet[0].id

    private_ip_address_allocation = "dynamic"

  }

  tags = azurerm_resource_group.rg.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "mgmtsg" {
  count               = var.deploy_management ? 1 : 0
  name                = "${var.resource.project}-mgmtsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_network_interface_security_group_association" "mgmtnic_sg_ass" {
  count                     = var.deploy_management ? 1 : 0
  network_interface_id      = azurerm_network_interface.mgmtnic[0].id
  network_security_group_id = azurerm_network_security_group.mgmtsg[0].id
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "mgmtvm" {
  count                 = var.deploy_management ? 1 : 0
  name                  = "${var.resource.project}-mgmtvm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.mgmtnic[0].id]
  size                  = var.mgmtvm.size
  priority              = "Spot"
  eviction_policy       = "Deallocate"

  computer_name  = "mgmtvm"
  admin_username = var.mgmtvm.username
  admin_password = var.mgmtvm.password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  // to get this run these following commands in azure cli
  //$location = "West Europe"
  //Get-AzVMImagePublisher -Location $location | Select PublisherName
  //$publisher = "MicrosoftWindowsServer"
  //Get-AzVMImageOffer -Location $location -PublisherName $publisher | Select Offer
  //$offer = "WindowsServer"
  //Get-AzVMImageSku -Location $location -PublisherName $publisher -Offer $offer | Select Skus
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }

  tags = azurerm_resource_group.rg.tags
}

data "azurerm_virtual_network" "vnetdest" {
  for_each            = { for i, v in var.vnet_peerings : i => v }
  name                = each.value.name
  resource_group_name = each.value.resourcegroup
}

resource "azurerm_virtual_network_peering" "vnet-peering-source" {
  for_each                  = { for i, v in var.vnet_peerings : i => v }
  name                      = "To${each.value.name}"
  resource_group_name       = azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.bastionmgmtvnet.name
  remote_virtual_network_id = data.azurerm_virtual_network.vnetdest["${each.key}"].id
}

resource "azurerm_virtual_network_peering" "vnet-peering-dest" {
  for_each                  = { for i, v in var.vnet_peerings : i => v }
  name                      = "To${var.resource.project}-vnet"
  resource_group_name       = each.value.resourcegroup
  virtual_network_name      = each.value.name
  remote_virtual_network_id = azurerm_virtual_network.bastionmgmtvnet.id
}
