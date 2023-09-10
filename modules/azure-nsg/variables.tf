variable "nsgname" {
  type        = string
  description = "the nsgname to set for the resources"
}


variable "resourcegroupname" {
  type        = string
  description = "the resourcegroupname to set for the resources"
}

variable "location" {
  type        = string
  description = "location to deploy to"
}


variable "tags" {
  description = "the tag to set for the resources"
}

variable "source_ip" {
    description = "The source ipd"
}