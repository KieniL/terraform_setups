/*
* # Graphs
*
* A terraform module which deploys S3 and dynamodb which will then be used for terraform remote state
* * [Terraform S3 Backend Documentation](https://www.terraform.io/language/settings/backends/s3)
* You need to set mfa deletion prevention yourself since it needs to be done with rootaccount
* <code>aws s3api put-bucket-versioning --bucket DOC-EXAMPLE-BUCKET1 --versioning-configuration Status=Enabled,MFADelete=Enabled --mfa "SERIAL 123456"</code>
* <br/><br/>
* ## S3
* **[README](./modules/s3/README.md)**<br/>
* ![Diagram](./modules/s3/graph.svg)
* ## Dynamodb
* **[README](./modules/dynamodb/README.md)**<br/>
* ![Diagram](./modules/dynamodb/graph.svg)
*/



module "s3" {
  source = "./modules/s3"

  tags = var.tags
}

# module "dynamodb" {
#   source = "./modules/dynamodb"

#   tags = var.tags
# }