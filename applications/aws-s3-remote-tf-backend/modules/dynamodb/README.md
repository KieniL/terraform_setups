<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.lock-table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_random_string"></a> [random\_string](#input\_random\_string) | a random string to have kind of uniqueness | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to set on the resources | <pre>object({<br>    project = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_statelock_id"></a> [statelock\_id](#output\_statelock\_id) | The id of the state lock dynamotable |
<!-- END_TF_DOCS -->