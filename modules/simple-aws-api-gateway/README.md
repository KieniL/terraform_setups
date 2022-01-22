![Alt text](./graph.svg)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend"></a> [backend](#module\_backend) | ./backend-infra | n/a |
| <a name="module_frontend"></a> [frontend](#module\_frontend) | ./frontend-infra | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | n/a | `string` | `"items-frontend-static-hosting"` | no |
| <a name="input_lambda_function_name"></a> [lambda\_function\_name](#input\_lambda\_function\_name) | n/a | `string` | `"apilambda"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `"simpleapigateway"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_table_name"></a> [table\_name](#input\_table\_name) | n/a | `string` | `"producttable"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->