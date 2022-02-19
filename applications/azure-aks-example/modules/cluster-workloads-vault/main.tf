/*
* # vault on aks deployment
* ![Diagram](./graph.svg)
*/

resource "helm_release" "vault" {
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = var.vault_namespace
  create_namespace = true
  replace          = true
  force_update     = true

  values = [
    "${file("${path.module}/files/override.yml")}"
  ]

}