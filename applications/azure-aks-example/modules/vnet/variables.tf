variable "location" {
  description = "location to deploy to"
}

variable "tags" {
  description = "the tag to set for the resources"
  default     = "aks"
}

variable "prefix" {
  description = "the project tag to set for the resources"
}

variable "resourcegroupname" {
  description = "the resourcegroupname to set for the resources"
}