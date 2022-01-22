terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "backend" {
  source = "./backend-infra"

  region  = var.region
  project = var.project

  lambda_function_name = var.lambda_function_name

  table_name = var.table_name

  bucket_url = module.frontend.bucket_url
}

module "frontend" {
  source = "./frontend-infra"

  region      = var.region
  project     = var.project
  bucket_name = var.bucket_name
}

