<!-- BEGIN_TF_DOCS -->
# vault on aks deployment
![Diagram](./graph.svg)

## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_certificate"></a> [client\_certificate](#input\_client\_certificate) | the client certificate to use | `any` | n/a | yes |
| <a name="input_client_key"></a> [client\_key](#input\_client\_key) | the clientkey  to use | `any` | n/a | yes |
| <a name="input_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#input\_cluster\_ca\_certificate) | the cluster ca certificate to use | `any` | n/a | yes |
| <a name="input_cluster_token"></a> [cluster\_token](#input\_cluster\_token) | the token of serviceaccount to use | `any` | n/a | yes |
| <a name="input_kubernetes_host"></a> [kubernetes\_host](#input\_kubernetes\_host) | the kubernetes host to use | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->