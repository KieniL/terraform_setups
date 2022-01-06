
output "function_app_name" {
  value = azurerm_function_app.function.name
  description = "Deployed function app name"
}

output "function_app_default_hostname" {
  value = azurerm_function_app.function.default_hostname
  description = "Deployed function app hostname"
}