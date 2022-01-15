variable "resource" {
  default = {
    prefix   = "webserver"
    location = "Germany West Central"
    project  = "scaled-webserver"
  }
}

variable "source_ip" {
  type        = string
  description = "Your source ip"
  default     = "1.1.1.1"
}

variable "vm" {
  default = {
    admin_username = "azureuser"
    size           = "Standard_F1s"
  }
}
