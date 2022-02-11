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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3"></a> [s3](#module\_s3) | ./modules/s3 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tags"></a> [tags](#input\_tags) | The tags to set on the resources | <pre>object({<br>    project = string<br>  })</pre> | <pre>{<br>  "project": "remotestage"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucketname"></a> [bucketname](#output\_bucketname) | the name of the bucket for the state storage |
<!-- END_TF_DOCS -->