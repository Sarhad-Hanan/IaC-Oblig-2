# Creates an Azure Storage Account with specified properties
resource "azurerm_storage_account" "storage" {
  name                     = "${var.environment}${var.name}" # Ensures unique naming per environment
  resource_group_name      = var.rgname                      # Associates the storage account with the specified resource group
  location                 = var.location                    # Specifies the deployment region
  account_tier             = "Standard"                      # Sets the performance tier (Standard or Premium)
  account_replication_type = "LRS"                           # Local Redundant Storage (LRS) for data redundancy
  min_tls_version          = "TLS1_2"                        # Specifies the minimum TLS version for secure connections
  tags                     = var.tags                        # Applies tags for better management and organization
}

# Creates an Azure Storage Container within the specified Storage Account
resource "azurerm_storage_container" "blob_container" {
  name                  = var.blob_container_name              # Name of the container for blob storage
  storage_account_name  = azurerm_storage_account.storage.name # Links the container to the created storage account
  container_access_type = "private"                            # Restricts access to the container to the account owner only
}
