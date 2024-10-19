output "sql_server_id" {
  description = "The ID of the SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name (FQDN) of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "The ID of the SQL Database"
  value       = azurerm_mssql_database.sql_database.id
}

output "sql_database_name" {
  description = "The name of the SQL Database"
  value       = azurerm_mssql_database.sql_database.name
}

output "sql_connection_string" {
  description = "The connection string to connect to the SQL Database"
  value       = "Server=${azurerm_mssql_server.sql_server.fully_qualified_domain_name};Database=${azurerm_mssql_database.sql_database.name};User ID=${var.administrator_login};Password=${var.administrator_password};"
  sensitive   = true
}
