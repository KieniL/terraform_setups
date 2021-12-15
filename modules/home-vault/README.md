<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_aws_secret_backend.aws](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend_role.role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_policy.aws-admin-policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accesskey"></a> [accesskey](#input\_accesskey) | The aws access key | `string` | `"aws"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | The aws secret key | `string` | `"aws"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->