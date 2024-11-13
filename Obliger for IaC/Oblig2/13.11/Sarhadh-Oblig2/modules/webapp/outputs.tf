# Output variable to expose the ID of the App Service Plan created by this module.
output "website_service_plan_id" {
  description = "ID of the App Service Plan"

  # The value retrieves the ID of the created App Service Plan, allowing other modules or configurations to reference it.
  value = azurerm_service_plan.webapp_service_plan.id
}

# Output variable to expose the default hostname of the web app created by this module.
output "webapp_url" {
  description = "URL of the Web App"
  value       = azurerm_linux_web_app.webapp.default_hostname
}
