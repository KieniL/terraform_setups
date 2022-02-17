output "client_certificate" {
  value = module.cluster.client_certificate
}

output "kube_config" {
  value = module.cluster.kube_config

  sensitive = true
}