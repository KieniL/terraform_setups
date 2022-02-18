terraform {
  backend "s3" {
    bucket         = "tfstate-utirtszb"
    key            = "s3preversion4.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tfstatelock-utirtszb"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

resource "random_string" "bucketname" {
  length    = 8
  special   = false
  lower     = true
  min_lower = 8 #force all characters to lowercase
}


resource "aws_s3_bucket" "b" {
  bucket = "preversion4-test-bucket-${random_string.bucketname.result}"
  acl    = "private"

  tags = {
    project        = "s3test"
  }
}