# Variable for specifying the deployment environment (e.g., dev, staging, prod)
variable "environment" {
  description = "Deployment environment (dev, staging, prod)" # This helps in setting up environment-specific configurations
  type        = string
}

# Variable for specifying the Azure region for resource deployment
variable "location" {
  description = "Azure region for resource deployment" # The region where the load balancer resources will be created
  type        = string
}

# Variable for specifying the name of the resource group
variable "resource_group_name" {
  description = "Name of the resource group" # Ensures resources are created within the specified resource group
  type        = string
}

# Variable for specifying tags to assign to resources for better organization and tracking
variable "tags" {
  description = "Tags to assign to resources" # Provides a mechanism to include metadata with the created resources
  type        = map(string)
}
