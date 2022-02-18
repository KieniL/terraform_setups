<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.spot_cluster_controller](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [null_resource.controller_rancher_installation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [kubectl_path_documents.rancher_manifests](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/path_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_awx_version"></a> [awx\_version](#input\_awx\_version) | the awx version to deploy | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->