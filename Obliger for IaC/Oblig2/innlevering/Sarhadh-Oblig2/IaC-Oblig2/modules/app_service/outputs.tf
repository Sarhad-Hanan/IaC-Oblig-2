output "app_service_id" {
  description = "The ID of the App Service."
  value       = coalesce(azurerm_windows_web_app.app_service[0].id, azurerm_linux_web_app.app_service_linux[0].id)
}

output "app_service_default_hostname" {
  description = "The default hostname of the App Service."
  value       = coalesce(azurerm_windows_web_app.app_service[0].default_site_hostname, azurerm_linux_web_app.app_service_linux[0].default_site_hostname)
}

output "app_service_plan_id" {
  description = "The ID of the App Service Plan."
  value       = azurerm_service_plan.app_service_plan.id
}
