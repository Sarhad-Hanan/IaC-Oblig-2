output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage_account.id
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the Storage Account"
  value       = azurerm_storage_account.storage_account.primary_access_key
  sensitive   = true
}

output "blob_container_url" {
  description = "The URL of the Blob Container"
  value       = azurerm_storage_container.blob_container.url
}
