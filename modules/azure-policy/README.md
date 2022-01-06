# azure-policy

A repo to store policies for azure in terraform

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
| [azurerm_policy_assignment.allowedLocationPolicyAssignment](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowedLocationSubPolicyId"></a> [allowedLocationSubPolicyId](#input\_allowedLocationSubPolicyId) | The PolicyId for allowedLocation Definition | `string` | `"PolId"` | no |
| <a name="input_allowedLocations"></a> [allowedLocations](#input\_allowedLocations) | The allowed Locations | `list(string)` | <pre>[<br>  "Germany West Central",<br>  "West Europe"<br>]</pre> | no |
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "tf-managed-policy",<br>  "project": "az-900-prep"<br>}</pre> | no |
| <a name="input_subscriptionId"></a> [subscriptionId](#input\_subscriptionId) | The subscriptionId | `string` | `"SubId"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->