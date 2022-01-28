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
| [azurerm_bastion_host.bastionhost](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/bastion_host) | resource |
| [azurerm_network_interface.mgmtnic](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface) | resource |
| [azurerm_network_interface_security_group_association.mgmtnic_sg_ass](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface_security_group_association) | resource |
| [azurerm_network_security_group.mgmtsg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.bastionip](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.azurebastionsubnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet) | resource |
| [azurerm_subnet.mgmtsubnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.example](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/virtual_network) | resource |
| [azurerm_windows_virtual_machine.mgmtvm](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_management"></a> [deploy\_management](#input\_deploy\_management) | Boolean to deploy management subnet and vm | `bool` | `false` | no |
| <a name="input_mgmtvm"></a> [mgmtvm](#input\_mgmtvm) | n/a | <pre>object({<br>    size     = string<br>    username = string<br>    password = string<br>  })</pre> | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "project": "centralbastion"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->