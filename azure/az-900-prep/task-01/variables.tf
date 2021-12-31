variable "vm" {
  default = {
    admin_username = "azureuser"
    size           = "Standard_D2s_v3"
  }
}

variable "source_ip" {
  type        = string
  description = "Your source ip"
  default     = "1.1.1.1"
}

variable "resource" {
  default = {
    prefix   = "az-900-01-tf"
    location = "West Europe"
    tag      = "az-900-prep"
  }
}