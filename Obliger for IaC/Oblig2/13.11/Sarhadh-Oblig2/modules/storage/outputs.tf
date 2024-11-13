# Outputs the name of the created storage account
output "storage_account_name" {
  description = "The name of the Azure Storage Account"
  value       = azurerm_storage_account.storage.name
}

# Outputs the name of the created blob container
output "blob_container_name" {
  description = "The name of the Blob container"
  value       = azurerm_storage_container.blob_container.name
}

# Outputs the primary access key for the storage account, allowing secure access
output "storage_account_access_key" {
  description = "The primary access key of the Azure Storage Account"
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true # Marks this output as sensitive to avoid exposure
}
