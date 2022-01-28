variable "resource" {
  default = {
    location = "Germany West Central"
    project  = "centralbastion"
  }
}

variable "deploy_management" {
  type        = bool
  description = "Boolean to deploy management subnet and vm"
  default     = false
}

variable "mgmtvm" {
  description = "Definition of the managementvm"
  type = object({
    size     = string
    username = string
    password = string
  })
}

variable "vnet_peerings" {
  description = "List of vnet peerings to add. id should be the full id of the resource to peer to. Name is the real vnet name to peer to. Resourcegroupname is the rg of the vnet to peer to"
  type = list(object({
    id                = string
    name              = string
    resourcegroupname = string
  }))
  default = []
}
