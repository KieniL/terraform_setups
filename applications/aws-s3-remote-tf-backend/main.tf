/*
* # Graphs
*
* A terraform module which deploys S3 and dynamodb which will then be used for terraform remote state
* * [Terraform S3 Backend Documentation](https://www.terraform.io/language/settings/backends/s3)
* You need to set mfa deletion prevention yourself since there are some restriction on usage in terraform (adding device number and mfacode as param)
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