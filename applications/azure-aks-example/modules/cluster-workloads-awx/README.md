<!-- BEGIN_TF_DOCS -->
# awx on aks deployment
![Diagram](./graph.svg)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.13.1 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.awx_operator](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.awx_operator_download](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [kubectl_path_documents.awx_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awx_version"></a> [awx\_version](#input\_awx\_version) | the awx version to deploy | `any` | n/a | yes |
| <a name="input_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#input\_cluster\_ca\_certificate) | the cluster ca certificate to use | `any` | n/a | yes |
| <a name="input_cluster_token"></a> [cluster\_token](#input\_cluster\_token) | the token of serviceaccount to use | `any` | n/a | yes |
| <a name="input_kubernetes_host"></a> [kubernetes\_host](#input\_kubernetes\_host) | the kubernetes host to use | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->