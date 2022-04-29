# vault-dynamic-credentials

A vault setup for studies to showcase dynamic credential provisioning in AWS and Azure

Use the **teraform.tfvars.example** to create **terraform.tfvars** with your variables.

To request credentials on vault-cli run: <br/>
<code>
vault read aws/creds/ROLE_NAME
vault read azure/creds/ROLE_NAME
</code>


For AWS a user with access key and secret access key needs to be created. <br/>

For Azure a seviceprincipal is necessary according to https://learn.hashicorp.com/tutorials/vault/azure-secrets

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
| [vault_approle_auth_backend_role.jenkins_deployer](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/approle_auth_backend_role) | resource |
| [vault_auth_backend.approle](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/auth_backend) | resource |
| [vault_aws_secret_backend.aws](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend) | resource |
| [vault_aws_secret_backend_role.admin_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.audit_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.developer_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.iam_manager_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_aws_secret_backend_role.storage_manager_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/aws_secret_backend_role) | resource |
| [vault_azure_secret_backend.azure](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend) | resource |
| [vault_azure_secret_backend_role.storage_manager_role](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/azure_secret_backend_role) | resource |
| [vault_generic_secret.azure_data](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_mount.kvv2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.jenkins_auth_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.jenkins_deployer_policy](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_token.jenkins_init_token](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_accesskey"></a> [aws\_accesskey](#input\_aws\_accesskey) | The AWS access key | `string` | n/a | yes |
| <a name="input_aws_default_role_lease_seconds"></a> [aws\_default\_role\_lease\_seconds](#input\_aws\_default\_role\_lease\_seconds) | The default seconds a user get access to the role. Defaults to 2 Minutes. | `string` | `"120"` | no |
| <a name="input_aws_max_role_lease_seconds"></a> [aws\_max\_role\_lease\_seconds](#input\_aws\_max\_role\_lease\_seconds) | The maximum seconds a user can request the role. Defaults to 5 Minutes. | `string` | `"300"` | no |
| <a name="input_aws_secretkey"></a> [aws\_secretkey](#input\_aws\_secretkey) | The AWS secret key | `string` | n/a | yes |
| <a name="input_azure_client_id"></a> [azure\_client\_id](#input\_azure\_client\_id) | The Azure client id | `string` | n/a | yes |
| <a name="input_azure_client_secret"></a> [azure\_client\_secret](#input\_azure\_client\_secret) | The Azure client secret | `string` | n/a | yes |
| <a name="input_azure_default_role_lease_seconds"></a> [azure\_default\_role\_lease\_seconds](#input\_azure\_default\_role\_lease\_seconds) | The default seconds a user get access to the role. Defaults to 2 Minutes. | `number` | `120` | no |
| <a name="input_azure_environment"></a> [azure\_environment](#input\_azure\_environment) | The Azure enviornment | `string` | n/a | yes |
| <a name="input_azure_max_role_lease_seconds"></a> [azure\_max\_role\_lease\_seconds](#input\_azure\_max\_role\_lease\_seconds) | The maximum seconds a user can request the role. Defaults to 5 Minutes. | `number` | `300` | no |
| <a name="input_azure_showcasing_resourcegroup"></a> [azure\_showcasing\_resourcegroup](#input\_azure\_showcasing\_resourcegroup) | the resourcegroup name to use for storageaccount | `string` | n/a | yes |
| <a name="input_azure_subscription_id"></a> [azure\_subscription\_id](#input\_azure\_subscription\_id) | The Azure subscription id | `string` | n/a | yes |
| <a name="input_azure_tenant_id"></a> [azure\_tenant\_id](#input\_azure\_tenant\_id) | The Azure tenant id | `string` | n/a | yes |
| <a name="input_secret_id_bound_ip_addresses"></a> [secret\_id\_bound\_ip\_addresses](#input\_secret\_id\_bound\_ip\_addresses) | the allowed ip adresses which can login to vault. | `list(string)` | n/a | yes |
| <a name="input_secret_id_ttl"></a> [secret\_id\_ttl](#input\_secret\_id\_ttl) | the time in second before secret id expires. | `number` | `120` | no |
| <a name="input_secret_id_uses"></a> [secret\_id\_uses](#input\_secret\_id\_uses) | the number of requests before secret id expires. | `number` | `1` | no |
| <a name="input_token_bound_ip_addresses"></a> [token\_bound\_ip\_addresses](#input\_token\_bound\_ip\_addresses) | the allowed ip adresses which can authenticate with the vault token. | `list(string)` | n/a | yes |
| <a name="input_vault_address"></a> [vault\_address](#input\_vault\_address) | the Adress to Hashicorp vault. | `string` | `"http://localhost:8200"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_token"></a> [jenkins\_token](#output\_jenkins\_token) | n/a |
<!-- END_TF_DOCS -->