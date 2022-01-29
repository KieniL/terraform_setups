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
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ./modules/bastion | n/a |
| <a name="module_managementvm"></a> [managementvm](#module\_managementvm) | ./modules/managementvm | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |
| <a name="module_vnetpeerings"></a> [vnetpeerings](#module\_vnetpeerings) | ./modules/vnet-peerings | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deploy_management"></a> [deploy\_management](#input\_deploy\_management) | Boolean to deploy management subnet and vm | `bool` | `false` | no |
| <a name="input_mgmtvm"></a> [mgmtvm](#input\_mgmtvm) | Definition of the managementvm | <pre>object({<br>    size     = string<br>    username = string<br>    password = string<br>  })</pre> | n/a | yes |
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "project": "centralbastion"<br>}</pre> | no |
| <a name="input_vnet_peerings"></a> [vnet\_peerings](#input\_vnet\_peerings) | List of vnet peerings to add. provider\_alias is the defined alias in the terraform. If you have more than one subscription you need to define multiple providers under modules/vnet-peerings (only tested with same subscription). Resourcegroup is the rg of the vnet to peer to. Name is the real vnet name to peer to. | <pre>list(object({<br>    provider_alias = string<br>    resourcegroup  = string<br>    name           = string<br>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->