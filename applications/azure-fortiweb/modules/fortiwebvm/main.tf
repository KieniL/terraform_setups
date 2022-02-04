resource "azurerm_network_interface" "externalnic" {
  name                          = "${var.project}-externalnic"
  location                      = var.location
  resource_group_name           = var.resourcegroupname
  enable_accelerated_networking = false
  enable_ip_forwarding          = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnetexternal.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
  }

  ip_configuration {
    name                          = "VirtualIP"
    subnet_id                     = var.subnetexternal.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.10"
    primary                       = false
  }
}

resource "azurerm_network_interface" "internalnic" {
  name                          = "${var.project}-internalnic"
  location                      = var.location
  resource_group_name           = var.resourcegroupname
  enable_accelerated_networking = false
  enable_ip_forwarding          = false

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnetinternal.id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_network_security_group" "fortinsg" {
  name                = "${var.project}-fortinsg"
  location            = var.location
  resource_group_name = var.resourcegroupname

  security_rule {
    name                       = "ALLOW_INCOMING_FROM_MY_IP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_ranges    = [80, 443]
    source_address_prefixes    = [var.source_ip]
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "externalnic_fortinsg_ass" {
  network_interface_id      = azurerm_network_interface.externalnic.id
  network_security_group_id = azurerm_network_security_group.fortinsg.id
}

resource "azurerm_linux_virtual_machine" "fortivm" {
  name                = "${var.project}-fortivm"
  location            = var.location
  resource_group_name = var.resourcegroupname
  size                = var.vmsize

  computer_name = "fortiweb"

  admin_username                  = var.username
  admin_password                  = var.password
  disable_password_authentication = false


  custom_data = base64encode("${path.module}/customdata.json")


  network_interface_ids = [
    azurerm_network_interface.externalnic.id,
    azurerm_network_interface.internalnic.id
  ]

  os_disk {
    name                 = "disk1"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "fortinet"
    offer     = "fortinet_fortiweb-vm_v5"
    sku       = "fortinet_fw-vm"
    version   = "6.3.17"
  }

  tags = var.tags
}

resource "azurerm_managed_disk" "fortidisk" {
  name                 = azurerm_linux_virtual_machine.fortivm.name
  location             = var.location
  resource_group_name  = var.resourcegroupname
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30

  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "diskattachment" {
  managed_disk_id    = azurerm_managed_disk.fortidisk.id
  virtual_machine_id = azurerm_linux_virtual_machine.fortivm.id
  lun                = "0"
  caching            = "ReadWrite"
}