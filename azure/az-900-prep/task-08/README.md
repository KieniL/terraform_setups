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
| [azurerm_app_service_plan.appservice](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/app_service_plan) | resource |
| [azurerm_function_app.function](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/function_app) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storageaccount](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/storage_account) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "az-900-08-tf",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->