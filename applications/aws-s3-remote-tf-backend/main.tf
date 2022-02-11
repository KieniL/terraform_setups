/*
* # Graphs
*
* A terraform module which deploys S3 and dynamodb which will then be used for terraform remote state
* * [Terraform S3 Backend Documentation](https://www.terraform.io/language/settings/backends/s3)
* <br/><br/>
* ## S3
* **[README](./modules/s3/README.md)**<br/>
* ![Diagram](./modules/s3/graph.svg)
* ## Dynamodb
* **[README](./modules/dynamodb/README.md)**<br/>
* ![Diagram](./modules/dynamodb/graph.svg)
*/

resource "random_string" "bucketname" {
  length    = 8
  special   = false
  lower     = true
  min_lower = 8 #force all characters to lowercase
}


module "s3" {
  source        = "./modules/s3"
  random_string = random_string.bucketname.result

  tags = var.tags
}

module "dynamodb" {
  source        = "./modules/dynamodb"
  random_string = random_string.bucketname.result

  tags = var.tags
}