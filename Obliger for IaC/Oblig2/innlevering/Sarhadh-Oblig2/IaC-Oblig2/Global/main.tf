provider "azurerm" {
  features {}
}

# Resource Group for Remote State Storage
resource "azurerm_resource_group" "remote_state_rg" {
  name     = var.remote_state_resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account for Remote State
resource "azurerm_storage_account" "remote_state_storage" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.remote_state_rg.name
  location                  = azurerm_resource_group.remote_state_rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
  tags                      = var.tags
}

# Blob Container for storing Terraform state files
resource "azurerm_storage_container" "remote_state_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.remote_state_storage.name
  container_access_type = "private"
}

# Output for remote state backend configuration
output "backend_storage_account_name" {
  description = "The name of the Azure Storage Account used for remote state"
  value       = azurerm_storage_account.remote_state_storage.name
}

output "backend_container_name" {
  description = "The name of the container inside the Storage Account for remote state storage"
  value       = azurerm_storage_container.remote_state_container.name
}

output "backend_access_key" {
  description = "The primary access key of the Storage Account used for remote state"
  value       = azurerm_storage_account.remote_state_storage.primary_access_key
  sensitive   = true
}


terraform {
  backend "azurerm" {
    resource_group_name   = "terraform-state-rg"          # Use the resource group created by the global module
    storage_account_name  = "tfstateaccount123"           # Use the storage account name from the global module
    container_name        = "tfstatecontainer"            # Use the container name from the global module
    key                   = "${terraform.workspace}.tfstate"  # Use a separate state file per environment (workspace)
  }
}
