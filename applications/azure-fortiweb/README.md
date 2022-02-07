**# Unfinished Repository**

<!-- BEGIN_TF_DOCS -->
# Fortiweb

A terraform module which deploys Fortiweb with Terraform Modules based on these two documentations
* [FortiwebDocumentationARM](https://docs.fortinet.com/document/fortiweb-public-cloud/latest/deploying-fortiweb-on-azure/403009/deploying-fortiweb-vm-from-arm-template)
* [ARMTemplateForConversion](https://ftnt.blob.core.windows.net/fortiweb-bootstrap-template/azure_bootstrap.json?sv=2020-04-08&st=2022-01-06T01%3A40%3A00Z&se=2025-01-08T01%3A40%3A00Z&sr=b&sp=r&sig=0aRrMzy6zHwbeXQPAvRoE0wjBOnT2ejaeWEv99NrogI%3D)
<br/><br/>
The Marketplace terms needs to be accepted with: <code>az vm image terms accept --urn fortinet:fortinet\_fortiweb-vm\_v5:fortinet\_fw-vm:6.3.17</code>

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.94.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=2.94.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_fortiwebvm"></a> [fortiwebvm](#module\_fortiwebvm) | ./modules/fortiwebvm | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adminPassword"></a> [adminPassword](#input\_adminPassword) | Admin password | `string` | `"5btCB9BESSvq0rDWvEDw"` | no |
| <a name="input_adminUserName"></a> [adminUserName](#input\_adminUserName) | Admin username for the FortiWeb instance. | `string` | `"azureuser"` | no |
| <a name="input_location"></a> [location](#input\_location) | location to deploy to | `string` | `"Germany West Central"` | no |
| <a name="input_project"></a> [project](#input\_project) | the project tag to set for the resources | `string` | `"azureforti"` | no |
| <a name="input_source_ip"></a> [source\_ip](#input\_source\_ip) | Your external IP | `any` | n/a | yes |
| <a name="input_vmSku"></a> [vmSku](#input\_vmSku) | Size of VM in the FortiWeb set VM instances. | `string` | `"Standard_F2s"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->



# Graphs
This is manual task


## VNET
**[README](./modules/vnet/README.md)**

![Diagramt](./modules/vnet/graph.svg)

<br/>

---

## Fortiwebvm
**[README](./modules/fortiwebvm/README.md)**

![Diagramt](./modules/fortiwebvm/graph.svg)

<br/>

---