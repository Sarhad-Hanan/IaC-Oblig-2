provider "azurerm" {
  features {}
}

# Random Name Generation for SQL Server
resource "random_pet" "sql_server_name" {
  length = 2
}

# SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.sql_server_prefix}${random_pet.sql_server_name.id}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12.0"
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_password

  tags = var.tags
}

# SQL Database
resource "azurerm_mssql_database" "sql_database" {
  name                = var.sql_database_name
  server_id           = azurerm_mssql_server.sql_server.id
  collation           = var.sql_collation
  max_size_gb         = var.sql_max_size_gb
  sku_name            = var.sql_sku_name

  tags = var.tags
}

# Optional SQL Firewall Rule to allow Azure services access
resource "azurerm_sql_firewall_rule" "allow_azure_access" {
  name                = "AllowAllWindowsAzureIps"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.sql_server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# Optional SQL Firewall Rule to allow external IP access (if required)
resource "azurerm_sql_firewall_rule" "allow_external_access" {
  count               = length(var.allowed_ip_ranges) > 0 ? 1 : 0
  name                = "AllowExternalIPs"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.sql_server.name
  start_ip_address    = element(var.allowed_ip_ranges, 0)
  end_ip_address      = element(var.allowed_ip_ranges, 1)
}
