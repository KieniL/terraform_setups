variable "vault_address" {
  type        = string
  description = "the Adress to Hashicorp vault."
  default     = "http://localhost:8200"
}

variable "vault_token" {
  type        = string
  description = "the token to Hashicorp vault."
}

