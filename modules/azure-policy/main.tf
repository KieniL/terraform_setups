terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_policy_assignment" "allowedLocationPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedlocation-policy-assignment"
  scope                = var.subscriptionId
  policy_definition_id = var.allowedLocationSubPolicyId
  description          = "Policy Assignment for allowed Location"
  display_name         = "Allowed Location Policy Assignment"

  metadata = <<METADATA
    {
    "category": "General"
    }
  METADATA

  parameters = <<PARAMETERS
  {
    "listOfAllowedLocations": {
      "value": ${jsonencode(var.allowedLocations)}
    }
  }
  PARAMETERS

}