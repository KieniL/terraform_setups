variable "vault_address" {
  type        = string
  description = "the Adress to Hashicorp vault."
  default     = "http://localhost:8200"
}

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
  description = "The maximum seconds a user can request the role. Defaults to 5 Minutes."
  default     = "300"
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

variable "azure_default_role_lease_seconds" {
  type        = number
  description = "The default seconds a user get access to the role. Defaults to 2 Minutes."
  default     = 120
}

variable "azure_max_role_lease_seconds" {
  type        = number
  description = "The maximum seconds a user can request the role. Defaults to 5 Minutes."
  default     = 300
}

variable "azure_showcasing_resourcegroup" {
  type        = string
  description = "the resourcegroup name to use for storageaccount"
}

variable "secret_id_uses" {
  type        = number
  description = "the number of requests before secret id expires."
  default     = 1
}

variable "secret_id_ttl" {
  type        = number
  description = "the time in second before secret id expires."
  default     = 120
}

variable "secret_id_bound_ip_addresses" {
  type        = list(string)
  description = "the allowed ip adresses which can login to vault."
}

variable "token_bound_ip_addresses" {
  type        = list(string)
  description = "the allowed ip adresses which can authenticate with the vault token."
}