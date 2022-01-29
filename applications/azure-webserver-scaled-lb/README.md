# azure-policy

A module to deploy azure linux vm on a webserver with autoscaling and loadbalancing

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
| [azurerm_lb.lb](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.backend_address_pool](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_outbound_rule.lb_outbound_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/lb_outbound_rule) | resource |
| [azurerm_lb_probe.probe](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lb_rule](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/lb_rule) | resource |
| [azurerm_linux_virtual_machine_scale_set.scaleset](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.autoscaler](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_network_security_group.sg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.lbip](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource"></a> [resource](#input\_resource) | n/a | `map` | <pre>{<br>  "location": "Germany West Central",<br>  "prefix": "webserver",<br>  "project": "scaled-webserver"<br>}</pre> | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your source ip | `string` | `"1.1.1.1"` | no |
| <a name="input_vm"></a> [vm](#input\_vm) | n/a | `map` | <pre>{<br>  "admin_username": "azureuser",<br>  "size": "Standard_F1s"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_loadbalancer_ip"></a> [loadbalancer\_ip](#output\_loadbalancer\_ip) | n/a |
| <a name="output_vnet"></a> [vnet](#output\_vnet) | n/a |
<!-- END_TF_DOCS -->