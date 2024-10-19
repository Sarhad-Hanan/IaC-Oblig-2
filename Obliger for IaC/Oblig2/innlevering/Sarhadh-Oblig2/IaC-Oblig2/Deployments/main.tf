provider "azurerm" {
  features {}
}

# Define the resource group for the environment
resource "azurerm_resource_group" "main" {
  name     = "${local.environment_prefix}-rg"
  location = var.location
}

# Networking Module
module "networking" {
  source              = "../modules/networking"
  vnet_name           = "${local.environment_prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  subnets = [
    {
      name          = "app-subnet"
      address_prefix = "10.0.1.0/24"
    },
    {
      name          = "db-subnet"
      address_prefix = "10.0.2.0/24"
    }
  ]
  
  load_balancer_sku            = "Standard"
  load_balancer_frontend_port  = 80
  load_balancer_backend_port   = 80
}

# App Service Module
module "app_service" {
  source               = "../modules/app_service"
  app_service_plan_prefix = "${local.environment_prefix}-asp-"
  app_service_prefix    = "${local.environment_prefix}-app-"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  os_type              = "Windows"  # or "Linux"
  sku_tier             = "Standard"
  sku_size             = "S1"
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "DATABASE_CONNECTION_STRING" = module.database.sql_connection_string
  }
}

# Database Module
module "database" {
  source              = "../modules/database"
  sql_server_prefix   = "${local.environment_prefix}-sql-"
  sql_database_name   = "${local.environment_prefix}-db"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  administrator_login = var.sql_admin_login
  administrator_password = var.sql_admin_password
  sql_sku_name        = "Basic"
  sql_max_size_gb     = 5
  allowed_ip_ranges   = []
}

# Storage Module
module "storage" {
  source               = "../modules/storage"
  storage_account_prefix = "${local.environment_prefix}-storage-"
  container_name       = "product-images"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  account_tier         = "Standard"
  account_replication_type = "LRS"
  container_access_type = "private"
}
