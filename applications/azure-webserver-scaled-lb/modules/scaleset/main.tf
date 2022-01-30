# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.project}-nsg"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}


locals {
  user_data = templatefile("${path.module}/user-data.sh", {})
}


resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                = "${var.project}-scaleset"
  location            = var.location
  resource_group_name = var.resourcegroupname
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

    network_security_group_id = azurerm_network_security_group.nsg.id

    ip_configuration {
      name                                         = "internal"
      primary                                      = true
      subnet_id                                    = var.subnet.id
      application_gateway_backend_address_pool_ids = [var.appgateway.backend_address_pool[0].id]
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

  tags = var.tags
}