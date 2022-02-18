terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubectl" {
  load_config_file = true
  config_path      = "../../aksconfig"
  #  host                   = var.kubernetes_host
  #  token                  = data.google_container_cluster.my_cluster.access_token
  #  cluster_ca_certificate = base64decode(data.google_container_cluster.my_cluster.master_auth.0.cluster_ca_certificate)
}


