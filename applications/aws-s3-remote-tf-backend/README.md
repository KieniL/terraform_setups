<!-- BEGIN_TF_DOCS -->
# Graphs

A terraform module which deploys S3 and dynamodb which will then be used for terraform remote state
* [Terraform S3 Backend Documentation](https://www.terraform.io/language/settings/backends/s3)
<br/><br/>
## S3
**[README](./modules/s3/README.md)**<br/>
![Diagram](./modules/s3/graph.svg)
## Dynamodb
**[README](./modules/dynamodb/README.md)**<br/>
![Diagram](./modules/dynamodb/graph.svg)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | ./modules/dynamodb | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.bucketname](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to set on the resources | <pre>object({<br>    project = string<br>  })</pre> | <pre>{<br>  "project": "remotestage"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucketname"></a> [bucketname](#output\_bucketname) | the name of the bucket for the state storage |
<!-- END_TF_DOCS -->