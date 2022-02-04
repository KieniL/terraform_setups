
variable "resource" {
  description = "Resource parameters"
  default = {
    location = "Germany West Central"
    project  = "sharedservices"
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
    size             = string
    username         = string
    password         = string
    autoshutdowntime = string
  })
}

variable "remote_resourcegroup" {
  description = "the resourcegroup to peer to"
  default     = "azureforti-rg"
}

variable "remote_vnet" {
  description = "the vnet to peer to"
  default     = "azureforti-vnet"
}
