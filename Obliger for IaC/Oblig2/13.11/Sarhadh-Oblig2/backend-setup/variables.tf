# Variables for backend setup

# Specifies the Azure region where resources will be deployed.
variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "westeurope"
}

# Defines the name of the resource group for backend storage.
variable "rgname" {
  description = "The name of the resource group used for backend state storage."
  type        = string
  default     = "rg-sarhad-backend-state"
}

# Specifies the name of the storage container that holds the Terraform state.
variable "storage_container_name" {
  description = "The name of the storage container for storing the Terraform state."
  type        = string
  default     = "tfstate"
}

# Sets the name of the storage account used for backend state storage. The name must be globally unique.
variable "backend_storage_name" {
  description = "The name of the storage account for backend state storage. Must be unique across Azure."
  type        = string
  default     = "sarhadbackendstorage"
}

# Holds the Azure subscription ID for deploying the resources.
variable "subscription_id" {
  description = "The Azure subscription ID where resources will be deployed."
  type        = string
}
