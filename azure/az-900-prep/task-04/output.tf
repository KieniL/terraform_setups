data "azurerm_public_ip" "public_ip01" {
  name                = "${var.resource.prefix}-publicip01"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [
    azurerm_windows_virtual_machine.vm01,
    azurerm_network_interface.nic01,
    azurerm_public_ip.public_ip01
  ]
}

data "azurerm_public_ip" "public_ip02" {
  name                = "${var.resource.prefix}-publicip02"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [
    azurerm_windows_virtual_machine.vm02,
    azurerm_network_interface.nic02,
    azurerm_public_ip.public_ip02
  ]
}

output "rdp_connection_string_01" {
  value       = "mstsc.exe /v:${data.azurerm_public_ip.public_ip01.ip_address}:3389"
  description = "The command for mstsc to the first vm"

  depends_on = [
    azurerm_windows_virtual_machine.vm01,
    azurerm_network_interface.nic01,
    azurerm_public_ip.public_ip01
  ]
}

output "local_win_credentials_01" {
  value       = "Windows user/pass = ${azurerm_windows_virtual_machine.vm01.admin_username}/${var.admin_password}"
  description = "the credentials for the frist vm"

  depends_on = [
    azurerm_windows_virtual_machine.vm01,
    azurerm_network_interface.nic01,
    azurerm_public_ip.public_ip01
  ]
}


output "rdp_connection_string_02" {
  value       = "mstsc.exe /v:${data.azurerm_public_ip.public_ip02.ip_address}:3389"
  description = "The command for mstsc to the second vm"

  depends_on = [
    azurerm_windows_virtual_machine.vm02,
    azurerm_network_interface.nic02,
    azurerm_public_ip.public_ip02
  ]
}

output "local_win_credentials_02" {
  value       = "Windows user/pass = ${azurerm_windows_virtual_machine.vm02.admin_username}/${var.admin_password}"
  description = "the credentials for the second vm"

  depends_on = [
    azurerm_windows_virtual_machine.vm02,
    azurerm_network_interface.nic02,
    azurerm_public_ip.public_ip02
  ]
}