variable "location" {
  type        = string
  description = "location to deploy to"
}

variable "vnet_name" {
  type        = string
  description = "name of the vnet"
}

variable "vnet_cidr" {
  type        = string
  description = "cidr of the vnet"
}

variable "tags" {
  description = "the tag to set for the resources"
}

variable "resourcegroupname" {
  type        = string
  description = "the resourcegroupname to set for the resources"
}

variable "subnets" {
  type = list(object({
    subnet_name = string
    subnet_cidr = string
  }))
  description = "The subnets for deployment"
}