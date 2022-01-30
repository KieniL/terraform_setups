# azure-image-processing

An azure module with logic apps which creates a storage account for upload and then resizes the images and send notifications of new image

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storageaccount](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.storagecontainer](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "project": "imageprocessor"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->