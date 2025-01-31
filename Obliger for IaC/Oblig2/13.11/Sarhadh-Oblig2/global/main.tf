# Specifies the required Terraform version and providers for the deployment.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.2.0"
    }
  }

  # The backend configuration will be supplied during the `terraform init` command via `-backend-config` argument.
  backend "azurerm" {}
}

# Configures the AzureRM provider with features and subscription ID.
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Retrieves the client configuration for the current Azure context.
data "azurerm_client_config" "current" {}

# Generates a random string to be used as a suffix for unique naming of resources.
resource "random_string" "suffix" {
  length  = 9
  special = false
  upper   = false
  numeric = false
}

# Generates a random string for the SQL admin login.
resource "random_string" "sql_admin_login" {
  length  = 10
  special = false
  upper   = false
  lower   = true
}

# Generates a secure random password for the SQL admin.
resource "random_password" "sql_admin_password" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>"
}

# Defines local values for environment-specific configurations and tagging.
locals {
  # Determines the SKU for the service plan and SQL database based on the environment.
  sku_name_service_plan = var.environment == "prod" ? "S1" : "B1"
  sku_name_sql_db       = var.environment == "prod" ? "S0" : "Basic"
  tags                  = merge(var.default_tags, { "Environment" = var.environment })
}



# Creates the main resource group for deploying resources, ensuring the name is unique using the random suffix.
resource "azurerm_resource_group" "main" {
  name     = "${var.environment}-${var.rgname}-${random_string.suffix.result}" # Combines the base name with the random suffix.
  location = var.location                                                # The region where the resource group will be created.
  tags     = var.default_tags                                            # Applies default tags for better management and tracking.
}



# Deploys the network module with environment-specific settings.
module "network" {
  source      = "../modules/network"
  environment = var.environment
  location    = azurerm_resource_group.main.location
  rgname      = azurerm_resource_group.main.name
  tags        = local.tags
}

# Deploys the storage module with a unique name generated by the random string resource.
module "storage" {
  source              = "../modules/storage"
  environment         = var.environment
  location    = azurerm_resource_group.main.location
  rgname      = azurerm_resource_group.main.name
  name                = "storage${random_string.suffix.result}"
  blob_container_name = var.blob_container_name
  tags                = local.tags
}

# Deploys the Key Vault module and sets up secrets for SQL admin credentials.
module "key_vault" {
  source             = "../modules/key_vault"
  location           = azurerm_resource_group.main.location
  rgname             = azurerm_resource_group.main.name
  key_vault_name     = "${var.environment}-kv-${random_string.suffix.result}"
  sa_access_key      = module.storage.storage_account_access_key
  sql_admin_login    = random_string.sql_admin_login.result
  sql_admin_password = random_password.sql_admin_password.result
  access_policies = [
    {
      tenant_id           = data.azurerm_client_config.current.tenant_id
      object_id           = data.azurerm_client_config.current.object_id
      secret_permissions  = ["Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"]
      key_permissions     = ["Get", "List", "Create", "Delete", "Recover", "Backup", "Restore"]
      storage_permissions = ["Get", "List", "Delete", "Set", "Update"]
    }
  ]
  tenant_id = data.azurerm_client_config.current.tenant_id
  tags      = local.tags
}

# Deploys the App Service Plan module with environment-specific SKU.
module "app_service_plan" {
  source                   = "../modules/webapp"
  environment              = var.environment
  location                 = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  webapp_service_plan_name = "webapp-plan-${random_string.suffix.result}"
  sku_name                 = local.sku_name_service_plan
  tags                     = local.tags
}

# Deploys the Load Balancer module with relevant environment settings.
module "load_balancer" {
  source      = "../modules/load_balancer"
  environment = var.environment
  location        = azurerm_resource_group.main.location
  resource_group_name      = azurerm_resource_group.main.name
  tags        = local.tags
}

# Deploys the SQL Database module and uses the admin credentials stored in Key Vault.
module "sql_database" {
  source                 = "../modules/sql_database"
  environment            = var.environment  
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  sql_server_name        = "sqlserver-${random_string.suffix.result}"
  sql_database_name      = "productdb-${random_string.suffix.result}"
  administrator_login    = random_string.sql_admin_login.result
  administrator_password = random_password.sql_admin_password.result
  sku_name               = local.sku_name_sql_db
  tags                   = local.tags
  max_size_gb            = var.max_size_gb
}
