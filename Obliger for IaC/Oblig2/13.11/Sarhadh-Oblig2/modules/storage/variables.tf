# Specifies the deployment environment (e.g., dev, staging, prod).
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

# Defines the Azure region where resources will be deployed.
variable "location" {
  description = "Azure region to deploy the resources in"
  type        = string
}

# Specifies the name of the resource group where resources will be created.
variable "rgname" {
  description = "Name of the resource group"
  type        = string
}

# Unique name for the storage account, which must be globally unique across all of Azure.
variable "name" {
  description = "The name for the storage account, must be globally unique"
  type        = string
}

# Specifies the name of the blob container within the storage account.
variable "blob_container_name" {
  description = "The name of the blob container"
  type        = string
}

# A map of tags to apply to the storage account and container.
variable "tags" {
  description = "Tags to assign to the storage account and container"
  type        = map(string)
}
