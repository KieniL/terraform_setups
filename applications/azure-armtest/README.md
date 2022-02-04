<!-- BEGIN_TF_DOCS -->
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
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
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