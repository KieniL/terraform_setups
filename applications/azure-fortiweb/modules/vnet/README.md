<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.95.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnetexternal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.subnetinternal](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | n/a | `any` | n/a | yes |
| <a name="input_resourcegroupname"></a> [resourcegroupname](#input\_resourcegroupname) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnetexternal"></a> [subnetexternal](#output\_subnetexternal) | n/a |
| <a name="output_subnetexternalstartadress"></a> [subnetexternalstartadress](#output\_subnetexternalstartadress) | n/a |
| <a name="output_subnetinternal"></a> [subnetinternal](#output\_subnetinternal) | n/a |
| <a name="output_subnetinternalstartadress"></a> [subnetinternalstartadress](#output\_subnetinternalstartadress) | n/a |
| <a name="output_vnet"></a> [vnet](#output\_vnet) | n/a |
<!-- END_TF_DOCS -->