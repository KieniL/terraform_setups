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
  description = "Some resource variables"
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