output "aks_get_credentials" {
  value       = "az aks get-credentials --resource-group ${var.prefix}-rg  --name ${var.prefix}-aks"
  description = "to receive the kubeconfig in cli run this"
}