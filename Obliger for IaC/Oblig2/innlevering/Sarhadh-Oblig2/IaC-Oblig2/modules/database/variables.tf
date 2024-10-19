variable "sql_server_prefix" {
  description = "Prefix for the SQL Server name"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL Database"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the SQL Server and Database will be created."
  type        = string
}

variable "location" {
  description = "The location/region where the SQL Server and Database will be created."
  type        = string
}

variable "administrator_login" {
  description = "The administrator login name for the SQL Server"
  type        = string
}

variable "administrator_password" {
  description = "The administrator password for the SQL Server"
  type        = string
  sensitive   = true
}

variable "sql_collation" {
  description = "The collation setting for the SQL Database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_max_size_gb" {
  description = "The maximum size of the SQL Database in GB"
  type        = number
  default     = 10
}

variable "sql_sku_name" {
  description = "The SKU name for the SQL Database (e.g., Basic, Standard, Premium)"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "Optional list of IP ranges to allow external access (start and end IP). Leave empty if not required."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to assign to resources"
  type        = map(string)
  default     = {}
}
