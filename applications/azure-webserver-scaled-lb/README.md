# azure-policy

A module to deploy azure linux vm on a webserver with autoscaling and loadbalancing

![Alt text](./graph.svg)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.94.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_appgateway"></a> [appgateway](#module\_appgateway) | ./modules/appgateway | n/a |
| <a name="module_monitoring"></a> [monitoring](#module\_monitoring) | ./modules/monitoring | n/a |
| <a name="module_scaleset"></a> [scaleset](#module\_scaleset) | ./modules/scaleset | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "webserver",<br>  "project": "scaled-webserver"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |
| <a name="input_vm"></a> [vm](#input\_vm) | n/a | `map` | <pre>{<br>  "admin_username": "azureuser",<br>  "size": "Standard_F1s"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gateway_ip"></a> [gateway\_ip](#output\_gateway\_ip) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
| <a name="output_vnet_resourcegroup"></a> [vnet\_resourcegroup](#output\_vnet\_resourcegroup) | n/a |
<!-- END_TF_DOCS -->