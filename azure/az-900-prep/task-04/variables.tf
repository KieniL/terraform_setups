variable "vm" {
  default = {
    admin_username = "azureuser"
    size           = "Standard_B2s"
  }
}

variable "source_ip" {
  type        = string
  description = "Your source ip"
  default     = "1.1.1.1"
}

variable "resource" {
  default = {
    prefix   = "az-900-04-tf"
    location = "Germany West Central"
    project  = "az-900-prep"
  }
}

variable "admin_password" {
  type        = string
  description = "The vm password"
  default     = "aws"
}