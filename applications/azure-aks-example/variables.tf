
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
  default     = "Standard_B2s"
}

variable "spot_vm_sizes" {
  description = "the spot vm sizes to use"
  type        = list(string)
  default = [
    "Standard_D2s_v3",
    "Standard_D2s_v4",
    "Standard_F2s_v2",
    "Standard_DS2_v2",
    "Standard_D2_v4",
    "Standard_D2ds_v4",
    "Standard_D2d_v4",
    "Standard_E2ds_v4",
    "Standard_E2s_v3",
    "Standard_E2_v4",
    "Standard_DS11-1_v2",
    "Standard_DS11_v2",
    "Standard_E4-2s_v3",
    "Standard_E4-2ds_v4",
    "Standard_DS3_v2"
  ]
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
  default     = 0
}


variable "spot_max_node_count" {
  description = "the max nodecount for the spot nodepool"
  default     = 3
}

variable "source_ip" {
  description = "Your external IP"
}

variable "vault_namespace" {
  description = "the namespace in which to deploy vault to"
  default     = "vault"
}

variable "awx_namespace" {
  description = "the namespace in which to deploy awx to"
  default     = "awx"
}