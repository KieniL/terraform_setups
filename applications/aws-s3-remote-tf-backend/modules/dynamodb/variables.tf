variable "tags" {
  description = "The tags to set on the resources"
  type = object({
    project = string
  })
}

variable "random_string" {
  type        = string
  description = "a random string to have kind of uniqueness"
}