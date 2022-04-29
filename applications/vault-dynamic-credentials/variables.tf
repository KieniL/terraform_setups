variable "aws_accesskey" {
  type        = string
  description = "The AWS access key"
}

variable "aws_secretkey" {
  type        = string
  description = "The AWS secret key"
}

variable "aws_default_role_lease_seconds" {
  type        = string
  description = "The default seconds a user get access to the role. Defaults to 2 Minutes."
  default     = "120"
}

variable "aws_max_role_lease_seconds" {
  type        = string
  description = "The maximum seconds a user can request the role. Defaults to 24 Hours."
  default     = "86400"
}

variable "azure_subscription_id" {
  type        = string
  description = "The Azure subscription id"
}

variable "azure_tenant_id" {
  type        = string
  description = "The Azure tenant id"
}

variable "azure_client_id" {
  type        = string
  description = "The Azure client id"
}

variable "azure_client_secret" {
  type        = string
  description = "The Azure client secret"
}

variable "azure_environment" {
  type        = string
  description = "The Azure enviornment"
}