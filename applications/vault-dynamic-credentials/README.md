# vault-dynamic-credentials

A vault setup for studies to showcase dynamic credential provisioning in AWS and Azure

Use the **teraform.tfvars.example** to create **terraform.tfvars** with your variables.

To request credentials on vault-cli run: <br/>
<code>
vault read aws/creds/ROLE_NAME
</code>

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | 3.5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_aws_secret_backend.aws](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend_role.audit_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.developer_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.iam_manager_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.storage_manager_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_accesskey"></a> [aws\_accesskey](#input\_aws\_accesskey) | The AWS access key | `string` | n/a | yes |
| <a name="input_aws_default_role_lease_seconds"></a> [aws\_default\_role\_lease\_seconds](#input\_aws\_default\_role\_lease\_seconds) | The default seconds a user get access to the role. Defaults to 2 Minutes. | `string` | `"120"` | no |
| <a name="input_aws_max_role_lease_seconds"></a> [aws\_max\_role\_lease\_seconds](#input\_aws\_max\_role\_lease\_seconds) | The maximum seconds a user can request the role. Defaults to 24 Hours. | `string` | `"86400"` | no |
| <a name="input_aws_secretkey"></a> [aws\_secretkey](#input\_aws\_secretkey) | The AWS secret key | `string` | n/a | yes |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | The Azure client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | The Azure client secret | `string` | n/a | yes |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Azure enviornment | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | The Azure subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | The Azure tenant id | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->