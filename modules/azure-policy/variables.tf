
variable "subscriptionId" {
  type        = string
  description = "The subscriptionId"
  default     = "SubId"
}

variable "allowedLocationSubPolicyId" {
  type        = string
  description = "The PolicyId for the default allowedLocation Definition"
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

variable "resource" {
  default = {
    prefix   = "tf-managed-policy"
    location = "Germany West Central"
    project  = "az-900-prep"
  }
}