variable "location" {
  description = "location to deploy to"
}

variable "tags" {
  description = "the tag to set for the resources"
  default     = "aks"
}

variable "prefix" {
  description = "the project tag to set for the resources"
}

variable "resourcegroupname" {
  description = "the resourcegroupname to set for the resources"
}

variable "subnet_id" {
  description = "the subnetId in which to deploy to"
}

variable "vm_size" {
  description = "the vm size to use"
}

variable "default_node_count" {
  description = "the nodecount for the default nodepool"
}

variable "spot_node_count" {
  description = "the nodecount for the spot nodepool"
}