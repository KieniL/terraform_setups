
variable "location" {
  description = "location to deploy to"
  default     = "Germany West Central"
}

variable "project" {
  description = "the project tag to set for the resources"
  default     = "azureforti"
}

variable "vmSku" {
  description = "Size of VM in the FortiWeb set VM instances."
  default     = "Standard_F2s"
}

variable "adminUserName" {
  description = "Admin username for the FortiWeb instance."
  default     = "azureuser"
}

variable "adminPassword" {
  description = "Admin password"
  default     = "5btCB9BESSvq0rDWvEDw"
}

variable "source_ip" {
  description = "Your external IP"
}