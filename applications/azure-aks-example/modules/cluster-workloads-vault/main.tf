/*
* # vault on aks deployment
* ![Diagram](./graph.svg)
*/

# resource "helm_release" "vault" {
#   name             = "vault"
#   repository       = "https://helm.releases.hashicorp.com"
#   chart            = "vault"
#   namespace        = "vault"
#   create_namespace = true

#   values = [
#     "${file("${path.module}/files/override.yml")}"
#   ]

# }