
output "function_app_name" {
  value       = azurerm_function_app.imagefunction.name
  description = "Name of deployed image function"
}