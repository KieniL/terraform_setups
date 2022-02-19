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

variable "default_vm_size" {
  description = "the default vm size to use"
}

variable "spot_vm_size" {
  description = "the spot vm size to use"
}

variable "default_min_node_count" {
  description = "the min nodecount for the default nodepool"
}

variable "default_max_node_count" {
  description = "the max nodecount for the default nodepool"
}

variable "spot_min_node_count" {
  description = "the min nodecount for the spot nodepool"
}

variable "spot_max_node_count" {
  description = "the max nodecount for the spot nodepool"
}


