
variable "location" {
  description = "location to deploy to"
  default     = "Germany West Central"
}

variable "project" {
  description = "the project tag to set for the resources"
  default     = "aks"
}

variable "prefix" {
  description = "the project tag to set for the resources"
  default     = "tfaks"
}

variable "awx_version" {
  description = "the awx version to deploy"
  default     = "0.13.0"
}

variable "default_vm_size" {
  description = "the vm size to use"
  default     = "Standard_D2s_v3"
}

variable "spot_vm_size" {
  description = "the spot vm size to use"
  default     = "Standard_D2s_v3"
}


variable "default_min_node_count" {
  description = "the min nodecount for the default nodepool"
  default     = 1
}

variable "default_max_node_count" {
  description = "the max nodecount for the default nodepool"
  default     = 3
}

variable "spot_min_node_count" {
  description = "the nodecount for the spot nodepool"
  default     = 2
}


variable "spot_max_node_count" {
  description = "the max nodecount for the spot nodepool"
  default     = 3
}