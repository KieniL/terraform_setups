variable "resourcegroup_name" {
  type        = string
  description = "The name of the resourcegroup"
}

variable "tags" {
  description = "the tag to set for the resources"
}

variable "location" {
  type        = string
  description = "location to deploy to"
}

variable "role_definition_name" {
  type = string
  description = "The role for the role assignment of the rg"
  default = null
}

variable "principal_id" {
  type = string
  description = "The principal id to set as the roleassignment"
  default = null
}
