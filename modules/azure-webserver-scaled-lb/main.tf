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
    project = var.resource.project
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "sg" {
  name                = "${var.resource.prefix}-sg"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name

  # disable to allow vnet communication
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

  # enable to enable lb communication
  # security_rule {
  #   name                       = "ALLOW_LB"
  #   priority                   = 4095
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "AzureLoadBalancer"
  #   destination_address_prefix = "*"
  # }

  security_rule {
    name                       = "SSH_VNET"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"
  }

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

locals {
  user_data = templatefile("${path.module}/user-data.sh", {})
}


resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                = "${var.resource.prefix}-scaleset"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = var.vm.size
  instances           = 1
  priority            = "Spot"
  eviction_policy     = "Deallocate"

  admin_username = var.vm.admin_username

  custom_data = base64encode(local.user_data)


  admin_ssh_key {
    username   = var.vm.admin_username
    public_key = file("C:\\Users\\lkrei/.ssh/azure_vm.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.subnet.id
    }
  }

  // to get this run these following commands in azure cli
  //$location = "Germany West Central"
  //Get-AzVMImagePublisher -Location $location | Select PublisherName
  //$publisher = "Canonical"
  //Get-AzVMImageOffer -Location $location -PublisherName $publisher | Select Offer
  //$offer = "0001-com-ubuntu-server-focal"
  //Get-AzVMImageSku -Location $location -PublisherName $publisher -Offer $offer | Select Skus
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to instances since it is handled by the autoscaler    
      instances,
    ]
  }

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_monitor_autoscale_setting" "autoscaler" {
  name                = "${var.resource.prefix}-autoscaling"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.scaleset.id

  profile {
    name = "defaultProfile"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.scaleset.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
        metric_namespace   = "microsoft.compute/virtualmachinescalesets"
        dimensions {
          name     = "AppName"
          operator = "Equals"
          values   = ["App1"]
        }
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.scaleset.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

  tags = {
    project = var.resource.project
  }

}