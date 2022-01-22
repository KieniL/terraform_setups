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

resource "aws_organizations_organization" "root" {
  # (resource arguments)
  # import with terraform import aws_organizations_organization.ACCOUNT_NAME ACCOUNT_NUMBER
}

resource "aws_organizations_organizational_unit" "develop" {
  name      = "Develop"
  parent_id = aws_organizations_organization.root.roots[0].id
}

resource "aws_organizations_account" "account" {
  for_each  = { for i, v in var.accounts : i => v }
  name      = each.value.name
  email     = each.value.mail
  role_name = "OrganizationAccountAccessRole"
  parent_id = aws_organizations_organizational_unit.develop.id

  tags = {
    project = var.project
  }
}