/*
* # vault on aks deployment
* ![Diagram](./graph.svg)
*/

locals {
  vault_vars = {
    hostname = "${var.vault_namespace}.${var.domainname}"
  }
}

resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = var.vault_namespace
  create_namespace = true
  replace          = true
  force_update     = true

  values = [
    templatefile("${path.module}/templates/override.yaml.tmpl", local.vault_vars)
  ]

}