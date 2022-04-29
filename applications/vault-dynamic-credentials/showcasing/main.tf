
provider "aws" {
  region = "eu-central-1"
}


resource "random_string" "bucketname" {
  length    = 8
  special   = false
  lower     = true
  min_lower = 8 #force all characters to lowercase
}


resource "aws_s3_bucket" "statestorage" {
  bucket = "tmp-${random_string.bucketname.result}"
}