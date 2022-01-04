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