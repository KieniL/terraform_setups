terraform {
  backend "s3" {
    bucket         = "tfstate-utirtszb"
    key            = "awspolicy.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tfstatelock-utirtszb"
  }
}
