# azure-image-processing

An azure module which creates the components for image processing with logic apps.<br/>
These include:
* a storageaccount
* a function for processing
* an eventgrid for notification
* an appserviceplan for the logic apps
* an app insight which needs to be added manually to the logicapp (no resource available in provider)
* a loganalytics workspace

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
| <a name="module_imgfunction"></a> [imgfunction](#module\_imgfunction) | ./modules/function | n/a |
| <a name="module_imglocicappcomponents"></a> [imglocicappcomponents](#module\_imglocicappcomponents) | ./modules/logicapps-components | n/a |
| <a name="module_imglocicappstandard"></a> [imglocicappstandard](#module\_imglocicappstandard) | ./modules/logicapp-standard | n/a |
| <a name="module_imgnotification"></a> [imgnotification](#module\_imgnotification) | ./modules/notification | n/a |
| <a name="module_imgstorageaccount"></a> [imgstorageaccount](#module\_imgstorageaccount) | ./modules/storageaccount | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "project": "imgprocessor"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_logicapphostname"></a> [logicapphostname](#output\_logicapphostname) | n/a |
<!-- END_TF_DOCS -->