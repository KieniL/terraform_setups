
variable "subscriptionId" {
  type        = string
  description = "The subscriptionId"
  default     = "SubId"
}

variable "allowedLocationSubPolicyId" {
  type        = string
  description = "The PolicyId for allowedLocation Definition"
  default     = "PolId"
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