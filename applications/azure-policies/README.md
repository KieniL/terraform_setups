# azure-policy

A repo to store policies for azure in terraform (allowedLocation and require tag)

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
| [azurerm_policy_assignment.allowedImagesPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_assignment) | resource |
| [azurerm_policy_assignment.allowedLocationPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_assignment) | resource |
| [azurerm_policy_assignment.allowedSkuPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_assignment) | resource |
| [azurerm_policy_assignment.requireTagPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_assignment) | resource |
| [azurerm_policy_definition.allowedimagespolicy](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_definition) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowedImages"></a> [allowedImages](#input\_allowedImages) | Map of images names for configuration. | <pre>list(object({<br>    publisher = string<br>    offer     = string<br>    sku       = string<br>    version   = string<br>  }))</pre> | n/a | yes |
| <a name="input_allowedLocationSubPolicyId"></a> [allowedLocationSubPolicyId](#input\_allowedLocationSubPolicyId) | The PolicyId for the default allowedLocation Definition | `string` | `"PolId"` | no |
| <a name="input_allowedLocations"></a> [allowedLocations](#input\_allowedLocations) | The allowed Locations | `list(string)` | <pre>[<br>  "Germany West Central",<br>  "West Europe"<br>]</pre> | no |
| <a name="input_allowedSkuPolicyId"></a> [allowedSkuPolicyId](#input\_allowedSkuPolicyId) | The PolicyId for the default allowedSku Definition | `string` | `"PolId"` | no |
| <a name="input_allowedSkus"></a> [allowedSkus](#input\_allowedSkus) | The allowed skus | `list(string)` | n/a | yes |
| <a name="input_networkwatcher_rg_Id"></a> [networkwatcher\_rg\_Id](#input\_networkwatcher\_rg\_Id) | The ResourceGroupId for the networkwatcher resourcegroup | `string` | `"rg"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "tf-managed-policy",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_subscriptionId"></a> [subscriptionId](#input\_subscriptionId) | The subscriptionId | `string` | `"SubId"` | no |
| <a name="input_tagName"></a> [tagName](#input\_tagName) | the tagName to require on all resources | `string` | `"project"` | no |
| <a name="input_tagPolicyId"></a> [tagPolicyId](#input\_tagPolicyId) | The PolicyDefinition Id for the default require tag Policy | `string` | `"PolId"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->