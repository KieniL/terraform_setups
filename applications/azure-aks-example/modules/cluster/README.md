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
| [azurerm_kubernetes_cluster_node_pool.akspool](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.aksroleassigments](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.aksroutetablerole](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [azurerm_user_assigned_identity.aksuseridentity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appgw_subnet_id"></a> [appgw\_subnet\_id](#input\_appgw\_subnet\_id) | the subnetId in which to deploy the appgateway to | `any` | n/a | yes |
| <a name="input_customroutetable_id"></a> [customroutetable\_id](#input\_customroutetable\_id) | the id of the custom route table as scope for identity | `any` | n/a | yes |
| <a name="input_default_max_node_count"></a> [default\_max\_node\_count](#input\_default\_max\_node\_count) | the max nodecount for the default nodepool | `any` | n/a | yes |
| <a name="input_default_min_node_count"></a> [default\_min\_node\_count](#input\_default\_min\_node\_count) | the min nodecount for the default nodepool | `any` | n/a | yes |
| <a name="input_default_vm_size"></a> [default\_vm\_size](#input\_default\_vm\_size) | the default vm size to use | `any` | n/a | yes |
| <a name="input_internal_subnet_id"></a> [internal\_subnet\_id](#input\_internal\_subnet\_id) | the internal subnetId in which to deploy to | `any` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | location to deploy to | `any` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | the project tag to set for the resources | `any` | n/a | yes |
| <a name="input_resourcegroupname"></a> [resourcegroupname](#input\_resourcegroupname) | the resourcegroupname to set for the resources | `any` | n/a | yes |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your external IP | `any` | n/a | yes |
| <a name="input_spot_max_node_count"></a> [spot\_max\_node\_count](#input\_spot\_max\_node\_count) | the max nodecount for the spot nodepool | `any` | n/a | yes |
| <a name="input_spot_min_node_count"></a> [spot\_min\_node\_count](#input\_spot\_min\_node\_count) | the min nodecount for the spot nodepool | `any` | n/a | yes |
| <a name="input_spot_vm_sizes"></a> [spot\_vm\_sizes](#input\_spot\_vm\_sizes) | the spot vm sizes to use | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | the tag to set for the resources | `string` | `"aks"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | n/a |
<!-- END_TF_DOCS -->