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

  zone_balance = true
  zones        = [1, 2, 3]


  single_placement_group = true

  # automatic_os_upgrade = true
  # upgrade_policy_mode  = "Rolling"

  # rolling_upgrade_policy {
  #   max_batch_instance_percent              = 20
  #   max_unhealthy_instance_percent          = 20
  #   max_unhealthy_upgraded_instance_percent = 5
  #   pause_time_between_batches              = "PT0S"
  # }

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
    name    = "nic"
    primary = true

    network_security_group_id = azurerm_network_security_group.sg.id

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_address_pool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lbnatpool.id]
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

resource "azurerm_public_ip" "ip" {
  name                = "${var.resource.prefix}-ip"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = azurerm_resource_group.rg.name

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_lb" "lb" {
  name                = "${var.resource.prefix}-lb"
  location            = var.resource.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "publicIPAddress"
    public_ip_address_id = azurerm_public_ip.ip.id
  }

  tags = {
    project = var.resource.project
  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  name                           = "${var.resource.prefix}-sshpool"
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 80
  frontend_ip_configuration_name = "publicIPAddress"
}

# resource "azurerm_lb_probe" "probe" {
#   name                = "${var.resource.prefix}-http-probe"
#   location            = var.resource.location
#   resource_group_name = azurerm_resource_group.rg.name
#   protocol            = "Http"
#   request_path        = "/health"
#   port                = 8080
# }



# resource "azurerm_lb_rule" "lb_rule" {
#   name                           = "${var.resource.prefix}-lb-rule"
#   resource_group_name            = azurerm_resource_group.rg.name
#   loadbalancer_id                = azurerm_lb.lb.id
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = "publicIPAddress"
# }

# resource "azurerm_public_ip" "natip" {
#   name                = "${var.resource.prefix}-natip"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.resource.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
#   zones               = ["1"]
# }

# resource "azurerm_public_ip_prefix" "ipprefix" {
#   name                = "${var.resource.prefix}-ipprefix"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.resource.location
#   prefix_length       = 30
#   zones               = ["1"]
# }

# resource "azurerm_nat_gateway" "nat" {
#   name                    = "${var.resource.prefix}-nat"
#   resource_group_name     = azurerm_resource_group.rg.name
#   location                = var.resource.location
#   public_ip_address_ids   = [azurerm_public_ip.natip.id]
#   public_ip_prefix_ids    = [azurerm_public_ip_prefix.ipprefix.id]
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 10
#   zones                   = ["1", "2", "3"]
# }