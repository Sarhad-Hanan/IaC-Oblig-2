provider "azurerm" {
  features {}
}

# Random Name Generation for App Service
resource "random_pet" "app_service_name" {
  length = 2
}

# App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.app_service_plan_prefix}${random_pet.app_service_name.id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

# App Service for Windows or Linux
resource "azurerm_windows_web_app" "app_service" {
  count               = var.os_type == "Windows" ? 1 : 0
  name                = "${var.app_service_prefix}${random_pet.app_service_name.id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_linux_web_app" "app_service_linux" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = "${var.app_service_prefix}${random_pet.app_service_name.id}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    always_on = true
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }
}

