# Main Terraform configuration for creating SQL Server and SQL Database in Azure

# SQL Server resource block
resource "azurerm_mssql_server" "sql_server" {
  # Naming convention using the deployment environment and provided server name
  name = "${var.environment}-${var.sql_server_name}"
  # Resource group where the SQL Server will be created
  resource_group_name = var.resource_group_name
  # Location (region) for the SQL Server
  location = var.location
  # SQL Server version (e.g., "12.0" or "15.0")
  version = var.sql_version
  # Admin login credentials for managing the SQL Server
  administrator_login           = var.administrator_login
  administrator_login_password  = var.administrator_password
  public_network_access_enabled = false
  minimum_tls_version           = "1.2" # Tags for resource organization and metadata

  tags = var.tags
}

# SQL Database resource block
resource "azurerm_mssql_database" "sql_database" {
  # Naming convention using the deployment environment and provided database name
  name = "${var.environment}-${var.sql_database_name}"
  # Reference to the SQL Server created above
  server_id = azurerm_mssql_server.sql_server.id
  # Maximum size for the SQL Database in gigabytes
  max_size_gb = var.max_size_gb
  # SKU (pricing tier) for the SQL Database
  sku_name = var.sku_name
  # Collation setting for the database
  collation = "SQL_Latin1_General_CP1_CI_AS"
  # License type to specify how the licensing is managed
  license_type = "LicenseIncluded"
  # Enclave type for additional data security options
  enclave_type = "VBS"

  # Lifecycle settings to manage the resource's behavior on deletion
  lifecycle {
    # Option to prevent resource destruction for added safety (set to true if needed)
    prevent_destroy = false
  }

  # Tags for resource organization and metadata
  tags = var.tags
}
