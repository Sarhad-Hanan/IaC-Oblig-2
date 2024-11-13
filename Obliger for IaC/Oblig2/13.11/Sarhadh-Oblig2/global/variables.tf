# Specifies the environment to deploy the infrastructure, such as dev, staging, or prod.
variable "environment" {
  description = "The environment to deploy to (e.g., dev, staging, prod)"
  type        = string
}

# Specifies the Azure region where resources will be deployed, ensuring consistency across environments.
variable "rgname" {
  description = "The name of the resource group"
  type        = string
  
}

# Specifies the Azure region where resources will be deployed, ensuring consistency across environments.
variable "location" {
  description = "The Azure region to deploy resources in."
  type        = string
  default     = "westeurope" # Default set to 'westeurope' for consistency across environments.
  
}
# Holds the Azure subscription ID required for the deployment, ensuring resources are created in the correct account.
variable "subscription_id" {
  description = "The subscription ID"
  type        = string
}

# Name of the resource group used for storing the Terraform backend state, crucial for remote state management.
variable "backend_rgname" {
  description = "The name of the resource group for the backend storage account"
  type        = string
}

# Name of the storage account for storing the backend state file, enabling remote state storage and consistency.
variable "backend_saname" {
  description = "The name of the storage account for the backend"
  type        = string
}

# Specifies the container within the storage account to store the backend state file. 
variable "backend_container_name" {
  description = "The name of the storage container for the backend"
  type        = string
  default     = "tfstate" # Default set to 'tfstate' for consistency across environments.
}

# Defines the name of the blob container for storing data, such as product images or other assets.
variable "blob_container_name" {
  description = "The name of the blob container"
  type        = string
  default     = "sarhad-container-data-storage" # A common default for storing product data.
}

# A map of default tags applied to all resources, ensuring consistent tagging for easy identification and management.
variable "default_tags" {
  description = "Default tags to apply to resources"
  type        = map(string)
  default = {
    Owner     = "OperaTerra AS" # The organization responsible for the resources.
    ManagedBy = "Terraform"     # Indicates that the resource is managed by Terraform.
  }
}

# Specifies the maximum size of the SQL database in gigabytes, allowing customization per environment.
variable "max_size_gb" {
  description = "The maximum size of the database in gigabytes"
  type        = number
  default     = 2 # Default size set to 2 GB for flexibility.
}
