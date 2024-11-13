# Outputs for backend resources to reference in other modules and configurations

# Output the name of the resource group
output "resource_group_name" {
  value       = azurerm_resource_group.backend_rg.name
  description = "The name of the resource group used for the backend infrastructure."
}

# Output the name of the storage container
output "storage_container_name" {
  value       = azurerm_storage_container.tfstate.name
  description = "The name of the storage container where the Terraform state is stored."
}

# Output the name of the storage account
output "backend_storage_name" {
  value       = azurerm_storage_account.backend_storage.name
  description = "The name of the storage account used for Terraform state storage."
}
