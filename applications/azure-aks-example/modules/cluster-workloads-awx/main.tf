resource "null_resource" "awx_operator_download" {

  provisioner "local-exec" {
    command = <<EOT
      echo "Downloading rancher config"
      curl -L https://raw.githubusercontent.com/ansible/awx-operator${var.awx_version}/deploy/awx-operator.yaml -o awx.yaml
    EOT
  }
}

data "kubectl_path_documents" "awx_manifests" {
  pattern    = "./awx.yaml"
  depends_on = [null_resource.awx_operator_download]
}

resource "kubectl_manifest" "awx_operator" {
  count     = length(data.kubectl_path_documents.awx_manifests.documents)
  yaml_body = element(data.kubectl_path_documents.awx_manifests.documents, count.index)
}