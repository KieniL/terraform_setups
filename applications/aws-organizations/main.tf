terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
}

resource "aws_organizations_account" "account" {
  for_each  = { for i, v in var.accounts : i => v }
  name      = each.value.name
  email     = each.value.mail
  role_name = "OrganizationAccountAccessRole"

  tags = {
    project = var.project
  }
}