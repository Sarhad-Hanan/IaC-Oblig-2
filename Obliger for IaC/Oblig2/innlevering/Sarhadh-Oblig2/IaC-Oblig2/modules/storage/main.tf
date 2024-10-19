provider "azurerm" {
  features {}
}

# Random Name Generation for Storage Account
resource "random_pet" "storage_account_name" {
  length = 2
}

# Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "${var.storage_account_prefix}${random_pet.storage_account_name.id}"
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true

  tags = var.tags
}

# Azure Blob Container
resource "azurerm_storage_container" "blob_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

