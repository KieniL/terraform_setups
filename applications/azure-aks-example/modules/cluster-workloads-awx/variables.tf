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