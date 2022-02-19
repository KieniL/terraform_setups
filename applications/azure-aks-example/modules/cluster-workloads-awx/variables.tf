variable "awx_version" {
  description = "the awx version to deploy"
}

variable "kubernetes_host" {
  description = "the kubernetes host to use"
}

variable "cluster_token" {
  description = "the token of serviceaccount to use"
}

variable "cluster_ca_certificate" {
  description = "the cluster ca certificate to use"
}

variable "client_certificate" {
  description = "the client certificate to use"
}

variable "client_key" {
  description = "the clientkey  to use"
}

variable "awx_namespace" {
  description = "the namespace in which to deploy awx to"
  default     = "awx"
}