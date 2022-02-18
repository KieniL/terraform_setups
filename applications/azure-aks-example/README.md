<!-- BEGIN_TF_DOCS -->
# AKS example

AKS deployment with terraform and following example applications: <br/>
* AWX

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.96.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_awx"></a> [awx](#module\_awx) | ./modules/cluster-workloads-awx | n/a |
| <a name="module_cluster"></a> [cluster](#module\_cluster) | ./modules/cluster | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awx_version"></a> [awx\_version](#input\_awx\_version) | the awx version to deploy | `string` | `"0.13.0"` | no |
| <a name="input_location"></a> [location](#input\_location) | location to deploy to | `string` | `"Germany West Central"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | the project tag to set for the resources | `string` | `"tfaks"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project tag to set for the resources | `string` | `"aks"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_get_credentials"></a> [aks\_get\_credentials](#output\_aks\_get\_credentials) | to receive the kubeconfig in cli run this |
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | n/a |
<!-- END_TF_DOCS -->