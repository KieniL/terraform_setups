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

resource "azurerm_policy_assignment" "requireTagPolicyAssignment" {
  name                 = "${var.resource.prefix}-requireTag-policy-assignment"
  scope                = var.subscriptionId
  policy_definition_id = var.tagPolicyId
  description          = "Policy Assignment for require Tag"
  display_name         = "Require Tag Policy Assignment"
  not_scopes           = [var.networkwatcher_rg_Id]

  metadata = <<METADATA
    {
    "category": "General"
    }
  METADATA

  parameters = <<PARAMETERS
  {
    "tagName": {
      "value": "${var.tagName}"
    }
  }
  PARAMETERS

}

resource "azurerm_policy_assignment" "allowedSkuPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedSku-policy-assignment"
  scope                = var.subscriptionId
  policy_definition_id = var.allowedSkuPolicyId
  description          = "Policy Assignment for allowedSku"
  display_name         = "Allowed Sku Policy Assignment"
  not_scopes           = [var.networkwatcher_rg_Id]

  metadata = <<METADATA
    {
    "category": "General"
    }
  METADATA

  parameters = <<PARAMETERS
  {
    "listOfAllowedSKUs": {
      "value": ${jsonencode(var.allowedSkus)}
    }
  }
  PARAMETERS

}


resource "azurerm_policy_definition" "allowedimagespolicy" {

  name         = "${var.resource.prefix}-allowedimages-policy-definition"
  description  = "Policy Definition for allowedImages"
  display_name = "Allowed Images Policy Definition"
  policy_type  = "Custom"
  mode         = "Indexed"

  metadata = <<METADATA
    {
    "category": "Compute"
    }

METADATA


  policy_rule = <<POLICY_RULE
    {
    "if": {
      "allOf": [
        {
          "field": "type",
          "in": [
            "Microsoft.Compute/VirtualMachines",
            "Microsoft.Compute/VirtualMachineScaleSets"
          ]
        },
        {
          "not": {
            "allOf": [
              {
                "field": "Microsoft.Compute/imagePublisher",
                "in": "[parameters('publishers')]"
              },
              {
                "field": "Microsoft.Compute/imageOffer",
                "in": "[parameters('offers')]"
              },
              {
                "field": "Microsoft.Compute/imageSku",
                "in": "[parameters('skus')]"
              },
              {
                "field": "Microsoft.Compute/imageVersion",
                "in": "[parameters('versions')]"
              }
            ]
          }
        }
      ]
    },
    "then": {
      "effect": "deny"
    }
  }
POLICY_RULE


  parameters = <<PARAMETERS
  {
    "publishers": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed Publishers for resources.",
        "displayName": "Allowed Publishers"
      }
    },
    "offers": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed offers for resources.",
        "displayName": "Allowed offers"
      }
    },
    "skus": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed skus for resources.",
        "displayName": "Allowed skus"
      }
    },
    "versions": {
      "type": "Array",
      "metadata": {
        "description": "The list of allowed versions for resources.",
        "displayName": "Allowed versions"
      }
    }
  }
PARAMETERS

}


resource "azurerm_policy_assignment" "allowedImagesPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedImages-policy-assignment"
  scope                = var.subscriptionId
  policy_definition_id = azurerm_policy_definition.allowedimagespolicy.id
  description          = "Policy Assignment for allowedImages"
  display_name         = "Allowed Images Policy Assignment"
  not_scopes           = [var.networkwatcher_rg_Id]

  metadata = <<METADATA
    {
    "category": "General"
    }
  METADATA

  parameters = <<PARAMETERS
  {
    "publishers": {
      "value": ${jsonencode(var.allowedImages.publishers)}
    },
    "offers": {
      "value": ${jsonencode(var.allowedImages.offers)}
    },
    "skus": {
      "value": ${jsonencode(var.allowedImages.skus)}
    },
    "versions": {
      "value": ${jsonencode(var.allowedImages.versions)}
    }
  }
  PARAMETERS

}