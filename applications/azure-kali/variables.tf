variable "vnet_resourcegroup_name" {
  type        = string
  description = "The name of the resourcegroup for the vnet"
}

variable "tags" {
  description = "the tag to set for the resources"
}

variable "location" {
  type        = string
  description = "location to deploy to"
}


variable "developer_resourcegroup" {
  type = list(object({
    name         = string
    principal_id = string
  }))
  description = "the resourcegroup to create for kali machines and assigne the developer"
}

variable "source_ip" {
  type = string
} 