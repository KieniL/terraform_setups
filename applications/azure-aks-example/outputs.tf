output "client_certificate" {
  value = module.cluster.client_certificate
}

output "kube_config" {
  value = module.cluster.kube_config

  sensitive = true
}

output "aks_get_credentials" {
  value       = "az aks get-credentials --resource-group ${var.prefix}-rg  --name ${var.prefix}-aks"
  description = "to receive the kubeconfig in cli run this"
}