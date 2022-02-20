variable "resourcegroupname" {
  description = "the resourcegroupname to set for the resources"
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

variable "dns_namespace" {
  description = "the namespace in which to deploy external-dns to"
}

variable "domainname" {
  description = "the domainname to set"
}

variable "gateway_client_id" {
  description = "the client id of the gateway to set."
}