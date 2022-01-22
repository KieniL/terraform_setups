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

resource "aws_organizations_policy" "requiretag" {
  name = "Project Tag Policy"

  type = "TAG_POLICY"

  content = <<CONTENT
{
    "tags": {
        "project": {
            "enforced_for": {
                "@@assign": []
            }
        }
    }
}
CONTENT
  tags = {
    project = var.project
  }
}