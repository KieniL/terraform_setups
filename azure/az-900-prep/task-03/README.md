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
| [azurerm_container_group.containerinstancegroup](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/container_group) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "az-900-03-tf",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_containerinstance_url"></a> [containerinstance\_url](#output\_containerinstance\_url) | The URL on which to access the containerinstance. |
<!-- END_TF_DOCS -->