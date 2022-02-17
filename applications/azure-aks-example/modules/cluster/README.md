<!-- BEGIN_TF_DOCS -->
# aks deployment
![Diagram](./graph.svg)

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.96.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | location to deploy to | `any` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | the project tag to set for the resources | `any` | n/a | yes |
| <a name="input_resourcegroupname"></a> [resourcegroupname](#input\_resourcegroupname) | the resourcegroupname to set for the resources | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | the tag to set for the resources | `string` | `"aks"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->