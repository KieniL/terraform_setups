resource "azurerm_network_interface" "mgmtnic" {
  name                = "${var.project}-mgmtnic"
  location            = var.location
  resource_group_name = var.resourcegroupname

  ip_configuration {
    name      = "${var.project}-mgmtnic-conf"
    subnet_id = var.mgmtsubnetId

    private_ip_address_allocation = "dynamic"

  }

  tags = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "mgmtsg" {
  name                = "${var.project}-mgmtsg"
  location            = var.location
  resource_group_name = var.resourcegroupname

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "mgmtnic_sg_ass" {
  network_interface_id      = azurerm_network_interface.mgmtnic.id
  network_security_group_id = azurerm_network_security_group.mgmtsg.id
}


# Create virtual machine
resource "azurerm_windows_virtual_machine" "mgmtvm" {
  name                  = "${var.project}-mgmtvm"
  location            = var.location
  resource_group_name = var.resourcegroupname
  network_interface_ids = [azurerm_network_interface.mgmtnic.id]
  size                  = var.mgmtvm.size

  computer_name  = "mgmtvm"
  admin_username = var.mgmtvm.username
  admin_password = var.mgmtvm.password

  timezone              = "Central European Standard Time"

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

  tags = var.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "mgmtvm" {
  virtual_machine_id = azurerm_windows_virtual_machine.mgmtvm.id
  location            = var.location
  enabled            = true

  daily_recurrence_time = var.mgmtvm.autoshutdowntime #time in format 1600 on which the vm is shutdown automatically
  timezone              = "Central European Standard Time"

  notification_settings {
    enabled         = false
  }

  tags = var.tags
}