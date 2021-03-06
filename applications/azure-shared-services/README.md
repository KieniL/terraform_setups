<!-- BEGIN_TF_DOCS -->
# README.md

This is the readme of the example repository for terraform-docs poc.

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
| <a name="input_mgmtvm"></a> [mgmtvm](#input\_mgmtvm) | Definition of the managementvm | <pre>object({<br>    size             = string<br>    username         = string<br>    password         = string<br>    autoshutdowntime = string<br>  })</pre> | n/a | yes |
| <a name="input_remote_resourcegroup"></a> [remote\_resourcegroup](#input\_remote\_resourcegroup) | the resourcegroup to peer to | `string` | `"azureforti-rg"` | no |
| <a name="input_remote_vnet"></a> [remote\_vnet](#input\_remote\_vnet) | the vnet to peer to | `string` | `"azureforti-vnet"` | no |
| <a name="input_resource"></a> [resource](#input\_resource) | Resource parameters | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "project": "sharedservices"<br>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->



# Graphs
This is manual task

## Bastion
**[README](./modules/bastion/README.md)**

![Diagram](./modules/bastion/graph.svg)

---

## Management
**[README](./modules/managementvm/README.md)**

![Diagram](./modules/managementvm/graph.svg)

---

## VNET
**[README](./modules/vnet/README.md)**

![Diagramt](./modules/vnet/graph.svg)

<br/>
---

## VNET-Peerings
**[README](./modules/vnet-peerings/README.md)**

![Diagram](./modules/vnet-peerings/graph.svg)