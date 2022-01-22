variable "project" {
  type        = string
  description = "the tag value for project tag"
}

variable "accounts" {
  description = "Map of project names to configuration."
  type = list(object({
    name = string
    mail = string
    role = string
  }))
}