
variable "subscriptionId" {
  type        = string
  description = "The subscriptionId"
  default     = "SubId"
}

variable "networkwatcher_rg_Id" {
  type        = string
  description = "The ResourceGroupId for the networkwatcher resourcegroup"
  default     = "rg"
}

variable "allowedLocationSubPolicyId" {
  type        = string
  description = "The PolicyId for the default allowedLocation Definition"
  default     = "PolId"
}

variable "allowedSkuPolicyId" {
  type        = string
  description = "The PolicyId for the default allowedSku Definition"
  default     = "PolId"
}

variable "tagPolicyId" {
  type        = string
  description = "The PolicyDefinition Id for the default require tag Policy"
  default     = "PolId"
}

variable "tagName" {
  default     = "project"
  type        = string
  description = "the tagName to require on all resources"
}

variable "allowedLocations" {
  type        = list(string)
  description = "The allowed Locations"
  default     = ["Germany West Central", "West Europe"]
}

variable "allowedSkus" {
  type        = list(string)
  description = "The allowed skus"
}

variable "resource" {
  default = {
    prefix   = "tf-managed-policy"
    location = "Germany West Central"
    project  = "az-900-prep"
  }
}

variable "allowedImages" {
  description = "Map of images for configuration."
  type = object({
    publishers = list(string)
    offers     = list(string)
    skus       = list(string)
    versions   = list(string)
  })
}