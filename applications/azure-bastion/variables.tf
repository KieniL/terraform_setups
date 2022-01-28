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
  description = "List of vnet peerings to add. Name is the real vnet name to peer to. Resourcegroup is the rg of the vnet to peer to"
  type = list(object({
    name          = string
    resourcegroup = string
  }))
  default = []
}
