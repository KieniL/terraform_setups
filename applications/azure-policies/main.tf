/*
* # azure-policy
* A repo to store policies for azure in terraform (allowedLocation, require tag, allowed vm sizes, allowed images)
* ![Alt text](./graph.svg)
*
*/

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.94.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}


data "azurerm_policy_definition" "allowedLocationPolicyDefinition" {
  display_name = "Allowed locations"
}
data "azurerm_policy_definition" "requireTagPolicyDefinition" {
  display_name = "Require a tag on resources"
}

data "azurerm_policy_definition" "inheritTagFromRGIFMissingPolicyDefinition" {
  display_name = "Inherit a tag from the resource group if missing"
}

data "azurerm_policy_definition" "allowedSkuPolicyDefinition" {
  display_name = "Allowed virtual machine size SKUs"
}

data "azurerm_resource_group" "networkwatcherRG" {
  name = "NetworkWatcherRG"
}

data "azurerm_resource_group" "defaultRG" {
  name = "DefaultResourceGroup-DEWC"
}

resource "azurerm_subscription_policy_assignment" "allowedLocationPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedlocation-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.allowedLocationPolicyDefinition.id
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


resource "azurerm_subscription_policy_assignment" "inheritTagFromRGIFMissingPolicyAssignment" {
  name                 = "${var.resource.prefix}-inheritTagFromRGIFMissing-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.inheritTagFromRGIFMissingPolicyDefinition.id
  description          = "Inherit Tag from ResourceGroup if missing"
  display_name         = "Inherit Tag from ResourceGroup if missing"
  not_scopes           = [data.azurerm_resource_group.networkwatcherRG.id, data.azurerm_resource_group.defaultRG.id]
  location             = var.location

  identity {
    type = "SystemAssigned"
  }

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


resource "azurerm_subscription_policy_assignment" "requireTagPolicyAssignment" {
  name                 = "${var.resource.prefix}-requireTag-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.requireTagPolicyDefinition.id
  description          = "Policy Assignment for require Tag"
  display_name         = "Require Tag Policy Assignment"
  not_scopes           = [data.azurerm_resource_group.networkwatcherRG.id, data.azurerm_resource_group.defaultRG.id]

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

resource "azurerm_subscription_policy_assignment" "allowedSkuPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedSku-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.allowedSkuPolicyDefinition.id
  description          = "Policy Assignment for allowedSku"
  display_name         = "Allowed Sku Policy Assignment"
  not_scopes           = [data.azurerm_resource_group.networkwatcherRG.id, data.azurerm_resource_group.defaultRG.id]

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
      "effect": "audit"
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


resource "azurerm_subscription_policy_assignment" "allowedImagesPolicyAssignment" {
  name                 = "${var.resource.prefix}-allowedImages-policy-assignment"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = azurerm_policy_definition.allowedimagespolicy.id
  description          = "Policy Assignment for allowedImages"
  display_name         = "Allowed Images Policy Assignment"
  not_scopes           = [data.azurerm_resource_group.networkwatcherRG.id, data.azurerm_resource_group.defaultRG.id]

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