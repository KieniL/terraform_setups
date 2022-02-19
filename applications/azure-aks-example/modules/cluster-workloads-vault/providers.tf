provider "helm" {
  kubernetes {
    host = var.kubernetes_host

    client_certificate     = var.client_certificate
    client_key             = var.client_key
    cluster_ca_certificate = var.cluster_ca_certificate
    token                  = var.cluster_token
  }
}