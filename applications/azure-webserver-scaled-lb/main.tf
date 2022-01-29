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
  name     = "${var.resource.prefix}-rg"
  location = var.resource.location
  tags = {
    project = var.resource.project
  }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "sg" {
  name                = "${var.resource.prefix}-sg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_subnet" "frontend" {
  name                 = "${var.resource.prefix}-frontendsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource.prefix}-backendsubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

locals {
  user_data = templatefile("${path.module}/user-data.sh", {})
}


resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                = "${var.resource.prefix}-scaleset"
  location            = azurerm_resource_group.rg.location
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

  admin_username                  = var.vm.admin_username
  admin_password                  = var.vm.password
  disable_password_authentication = false

  custom_data = base64encode(local.user_data)

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "nic"
    primary = true

    network_security_group_id = azurerm_network_security_group.sg.id

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

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_monitor_autoscale_setting" "autoscaler" {
  name                = "${var.resource.prefix}-autoscaling"
  location            = azurerm_resource_group.rg.location
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

  tags = azurerm_resource_group.rg.tags

}

# resource "azurerm_log_analytics_workspace" "lbloganalyticsworkspace" {
#   name                = "${var.resource.prefix}-lb-loganalytics"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30

#   tags = azurerm_resource_group.rg.tags
# }

resource "azurerm_public_ip" "gatewayip" {
  name                = "${var.resource.prefix}-gatewayip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = azurerm_resource_group.rg.tags
}

resource "azurerm_application_gateway" "appgateway" {
  name                = "${var.resource.prefix}-appgateway"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    name = "Standard_Small"
    tier = "Standard"
  }

  autoscale_configuration {
    min_capacity = 1
    max_capacity = 5
  }

  gateway_ip_configuration {
    name      = "${var.resource.prefix}-gateway-ip-configuration"
    subnet_id = azurerm_subnet.frontend.id
  }

  frontend_port {
    name = "${var.resource.prefix}-frontendportname"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.resource.prefix}-frontendipconfig"
    public_ip_address_id = azurerm_public_ip.gatewayip.id
  }

  backend_address_pool {
    name = "${var.resource.prefix}-backendpool"
  }

  backend_http_settings {
    name                  = "${var.resource.prefix}-httpsettings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${var.resource.prefix}-httplistener"
    frontend_ip_configuration_name = "${var.resource.prefix}-frontendipconfig"
    frontend_port_name             = "${var.resource.prefix}-frontendportname"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.resource.prefix}-requestroutingrule"
    rule_type                  = "Basic"
    http_listener_name         = "${var.resource.prefix}-httplistener"
    backend_address_pool_name  = "${var.resource.prefix}-backendpool"
    backend_http_settings_name = "${var.resource.prefix}-httpsettings"
  }
}