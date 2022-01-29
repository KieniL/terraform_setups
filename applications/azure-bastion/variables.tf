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
  description = "List of vnet peerings to add. provider_alias is the defined alias in the terraform. If you have more than one subscription you need to define multiple providers under modules/vnet-peerings (only tested with same subscription). Resourcegroup is the rg of the vnet to peer to. Name is the real vnet name to peer to. "
  type = list(object({
    provider_alias = string
    resourcegroup  = string
    name           = string
  }))
  default = []
}
