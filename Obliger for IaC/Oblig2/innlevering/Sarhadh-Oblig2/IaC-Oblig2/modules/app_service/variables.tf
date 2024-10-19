variable "app_service_plan_prefix" {
  description = "Prefix for the App Service Plan name"
  type        = string
}

variable "app_service_prefix" {
  description = "Prefix for the App Service name"
  type        = string
}

variable "location" {
  description = "The location/region where the App Service and Plan will be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the App Service and Plan will be created."
  type        = string
}

variable "os_type" {
  description = "The operating system for the App Service (Windows or Linux)"
  type        = string
}

variable "sku_tier" {
  description = "The SKU tier of the App Service Plan (e.g., Free, Basic, Standard, Premium)"
  type        = string
}

variable "sku_size" {
  description = "The SKU size of the App Service Plan (e.g., B1, P1v2, S1)"
  type        = string
}

variable "app_settings" {
  description = "A map of app settings for the App Service"
  type = map(string)
  default = {}
}
