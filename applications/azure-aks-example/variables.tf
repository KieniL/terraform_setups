
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
  default     = "0.17.0"
}