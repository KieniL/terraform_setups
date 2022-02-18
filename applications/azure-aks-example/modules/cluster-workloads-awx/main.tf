/*
* # awx on aks deployment
* ![Diagram](./graph.svg)
*/

data "http" "awxoperatormanifestfile" {
  url = "https://raw.githubusercontent.com/ansible/awx-operator/${var.awx_version}/deploy/awx-operator.yaml"
}

resource "kubectl_manifest" "awxoperatormanifest" {
  yaml_body = data.http.awxoperatormanifestfile.body
}
