variable "tags" {
  description = "The tags to set on the resources"
  type = object({
    project = string
  })
}