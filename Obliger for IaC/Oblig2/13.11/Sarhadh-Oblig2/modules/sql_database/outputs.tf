# Output for the name of the SQL Server
output "sql_server_name" {
  description = "Name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.name
}

# Output for the name of the SQL Database
output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.sql_database.name
}
