![Alt text](./graph.svg)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.nic01](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface.nic02](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.nic_sg_ass_01](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_interface_security_group_association.nic_sg_ass_02](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.sg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.public_ip01](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/public_ip) | resource |
| [azurerm_public_ip.public_ip02](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine.vm01](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/windows_virtual_machine) | resource |
| [azurerm_windows_virtual_machine.vm02](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/windows_virtual_machine) | resource |
| [azurerm_public_ip.public_ip01](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/data-sources/public_ip) | data source |
| [azurerm_public_ip.public_ip02](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/data-sources/public_ip) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The vm password | `string` | `"aws"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "az-900-04-tf",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |
| <a name="input_vm"></a> [vm](#input\_vm) | n/a | `map` | <pre>{<br>  "admin_username": "azureuser",<br>  "size": "Standard_B2s"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_local_win_credentials_01"></a> [local\_win\_credentials\_01](#output\_local\_win\_credentials\_01) | the credentials for the frist vm |
| <a name="output_local_win_credentials_02"></a> [local\_win\_credentials\_02](#output\_local\_win\_credentials\_02) | the credentials for the second vm |
| <a name="output_rdp_connection_string_01"></a> [rdp\_connection\_string\_01](#output\_rdp\_connection\_string\_01) | The command for mstsc to the first vm |
| <a name="output_rdp_connection_string_02"></a> [rdp\_connection\_string\_02](#output\_rdp\_connection\_string\_02) | The command for mstsc to the second vm |
<!-- END_TF_DOCS -->