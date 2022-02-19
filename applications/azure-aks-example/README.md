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
| <a name="module_vault"></a> [vault](#module\_vault) | ./modules/cluster-workloads-vault | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awx_version"></a> [awx\_version](#input\_awx\_version) | the awx version to deploy | `string` | `"0.13.0"` | no |
| <a name="input_default_max_node_count"></a> [default\_max\_node\_count](#input\_default\_max\_node\_count) | the max nodecount for the default nodepool | `number` | `3` | no |
| <a name="input_default_min_node_count"></a> [default\_min\_node\_count](#input\_default\_min\_node\_count) | the min nodecount for the default nodepool | `number` | `1` | no |
| <a name="input_default_vm_size"></a> [default\_vm\_size](#input\_default\_vm\_size) | the vm size to use | `string` | `"Standard_D2s_v3"` | no |
| <a name="input_location"></a> [location](#input\_location) | location to deploy to | `string` | `"Germany West Central"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | the project tag to set for the resources | `string` | `"tfaks"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project tag to set for the resources | `string` | `"aks"` | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your external IP | `any` | n/a | yes |
| <a name="input_spot_max_node_count"></a> [spot\_max\_node\_count](#input\_spot\_max\_node\_count) | the max nodecount for the spot nodepool | `number` | `3` | no |
| <a name="input_spot_min_node_count"></a> [spot\_min\_node\_count](#input\_spot\_min\_node\_count) | the nodecount for the spot nodepool | `number` | `1` | no |
| <a name="input_spot_vm_size"></a> [spot\_vm\_size](#input\_spot\_vm\_size) | the spot vm size to use | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_get_credentials"></a> [aks\_get\_credentials](#output\_aks\_get\_credentials) | to receive the kubeconfig in cli run this |
<!-- END_TF_DOCS -->