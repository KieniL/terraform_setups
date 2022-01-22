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
}

module "frontend" {
  source = "./frontend-infra"

  region  = var.region
  project = var.project
}

