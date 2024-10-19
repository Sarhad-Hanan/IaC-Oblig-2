variable "location" {
  description = "The location/region for the resources"
  type        = string
}

variable "sql_admin_login" {
  description = "SQL Server administrator login"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server administrator password"
  type        = string
  sensitive   = true
}
