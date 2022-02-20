/*
* # awx on aks deployment
* ![Diagram](./graph.svg)
*/

locals {
  awx_vars = {
    namespace = var.awx_namespace,
    hostname  = "${var.awx_namespace}.${var.domainname}"
  }
}

resource "kubectl_manifest" "awxnamespace" {
  yaml_body = <<YAML
kind: Namespace
apiVersion: v1
metadata:
  name: ${var.awx_namespace}
  labels:
    name: ${var.awx_namespace}
YAML
}

data "http" "awxoperatormanifestfile" {
  url = "https://raw.githubusercontent.com/ansible/awx-operator/${var.awx_version}/deploy/awx-operator.yaml"
}

data "kubectl_file_documents" "awxoperatordocs" {
  content = data.http.awxoperatormanifestfile.body
}

resource "kubectl_manifest" "awxoperatormanifest" {
  for_each           = data.kubectl_file_documents.awxoperatordocs.manifests
  yaml_body          = each.value
  override_namespace = var.awx_namespace
}

resource "kubectl_manifest" "awx" {
  yaml_body = templatefile("${path.module}/templates/ansible-awx.yaml.tmpl", local.awx_vars)
}

