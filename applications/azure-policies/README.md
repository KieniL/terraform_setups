<!-- BEGIN_TF_DOCS -->
# azure-policy
A repo to store policies for azure in terraform (allowedLocation, require tag, allowed vm sizes, allowed images)
![Alt text](./graph.svg)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.95.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_policy_definition.allowedimagespolicy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition) | resource |
| [azurerm_subscription_policy_assignment.allowedImagesPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.allowedLocationPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.allowedSkuPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_subscription_policy_assignment.requireTagPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subscription_policy_assignment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_policy_definition.allowedLocationPolicyDefinition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.allowedSkuPolicyDefinition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_policy_definition.requireTagPolicyDefinition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/policy_definition) | data source |
| [azurerm_resource_group.defaultRG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_resource_group.networkwatcherRG](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowedImages"></a> [allowedImages](#input\_allowedImages) | Map of images for configuration. | <pre>object({<br>    publishers = list(string)<br>    offers     = list(string)<br>    skus       = list(string)<br>    versions   = list(string)<br>  })</pre> | n/a | yes |
| <a name="input_allowedLocations"></a> [allowedLocations](#input\_allowedLocations) | The allowed Locations | `list(string)` | <pre>[<br>  "Germany West Central",<br>  "West Europe"<br>]</pre> | no |
| <a name="input_allowedSkus"></a> [allowedSkus](#input\_allowedSkus) | The allowed skus | `list(string)` | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | Some resource variables | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "tf-managed-policy",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_tagName"></a> [tagName](#input\_tagName) | the tagName to require on all resources | `string` | `"project"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->