terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource.prefix}-rg"
  location = var.resource.location
  tags = {
    ms-resource-usage = var.resource.tag
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "sg" {
  name                = "${var.resource.prefix}-sg"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "DENY_VNET"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "ALLOW_LB"
    priority                   = 4095
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RPD_VNET"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP_VNET"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"

  }

  tags = {
    ms-resource-usage = var.resource.tag
  }
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.resource.prefix}-publicip"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"

  tags = {
    ms-resource-usage = var.resource.tag
  }
}
# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.resource.prefix}-nic"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name      = "${var.resource.prefix}-nic-conf"
    subnet_id = azurerm_subnet.subnet.id

    private_ip_address_allocation = "dynamic"

    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  tags = {
    ms-resource-usage = var.resource.tag
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface_security_group_association" "nic_sg_ass" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.sg.id
}

resource "azurerm_availability_set" "avset" {
  name                        = "${var.resource.prefix}-appavset"
  location                    = var.resource.location
  resource_group_name         = azurerm_resource_group.rg.name
  managed                     = "true"
  platform_fault_domain_count = 2 # default 3 cannot be used

  tags = {
    ms-resource-usage = var.resource.tag
  }
}

# Create virtual machine
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.resource.prefix}-vm"
  location              = var.resource.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm.size
  availability_set_id   = azurerm_availability_set.avset.id

  computer_name  = "${var.resource.prefix}-vm"
  admin_username = var.vm.admin_username
  admin_password = var.vm.admin_password

  os_disk {
    name                 = "${var.resource.prefix}-osdisks"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"

    disk_size_gb = "127" # increase default os disk
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

  tags = {
    ms-resource-usage = var.resource.tag
  }
}
