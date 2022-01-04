output "app_service_url" {
  value       = "https://${azurerm_app_service.appservice.default_site_hostname}"
  description = "The URL on which to access the appservice."

  depends_on = [
    azurerm_app_service.appservice,
    azurerm_app_service_plan.service_plan
  ]
}
