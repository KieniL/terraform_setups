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
| [azurerm_app_service.appservice](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/app_service) | resource |
| [azurerm_app_service_plan.service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/app_service_plan) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "az-900-02-tf",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_app_service_url"></a> [app\_service\_url](#output\_app\_service\_url) | The URL on which to access the appservice. |
<!-- END_TF_DOCS -->