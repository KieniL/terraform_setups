/*
* # awx on aks deployment
* ![Diagram](./graph.svg)
*/

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
  yaml_body          = file("${path.module}/files/ansible-awx.yml")
  override_namespace = var.awx_namespace
}