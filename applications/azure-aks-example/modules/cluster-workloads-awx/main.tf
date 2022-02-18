/*
* # awx on aks deployment
* ![Diagram](./graph.svg)
*/

data "http" "awxoperatormanifestfile" {
  url = "https://raw.githubusercontent.com/ansible/awx-operator/${var.awx_version}/deploy/awx-operator.yaml"
}

data "kubectl_file_documents" "docs" {
  content = data.http.awxoperatormanifestfile.body
}

resource "kubectl_manifest" "test" {
  for_each  = data.kubectl_file_documents.docs.manifests
  yaml_body = each.value
}