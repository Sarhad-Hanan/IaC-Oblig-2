# Specifies the deployment environment (e.g., dev, staging, prod)
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

# Specifies the Azure region for resource deployment
variable "location" {
  description = "Azure region for resource deployment"
  type        = string
}

# Specifies the name of the resource group where the SQL resources will be deployed
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Specifies the name of the SQL Server
variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
}

# Specifies the admin username for the SQL Server
variable "administrator_login" {
  description = "SQL Server admin username"
  type        = string
}

# Specifies the admin password for the SQL Server; marked as sensitive for security
variable "administrator_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

# Specifies the name of the SQL Database
variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
}

# Specifies the SKU name for the SQL Database, which determines its performance and cost
variable "sku_name" {
  description = "The SKU name for the SQL Database (e.g., S0, S1)"
  type        = string
}

# Specifies the maximum size of the database in gigabytes
variable "max_size_gb" {
  description = "Maximum size of the database in gigabytes"
  type        = number
  default     = 2
}

# Specifies tags to assign to SQL resources for better organization and cost management
variable "tags" {
  description = "Tags to assign to the SQL resources"
  type        = map(string)
}

# Specifies the version of SQL Server to deploy; default is set to "12.0"
variable "sql_version" {
  description = "The version of SQL Server to deploy"
  type        = string
  default     = "12.0"
}
