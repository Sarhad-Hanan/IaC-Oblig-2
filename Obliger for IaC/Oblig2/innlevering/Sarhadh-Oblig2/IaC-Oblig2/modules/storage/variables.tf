variable "storage_account_prefix" {
  description = "Prefix for the Storage Account name"
  type        = string
}

variable "container_name" {
  description = "The name of the Blob Container"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Storage Account will be created"
  type        = string
}

variable "location" {
  description = "The location/region where the Storage Account will be created"
  type        = string
}

variable "account_tier" {
  description = "The performance tier of the Storage Account (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The replication type of the Storage Account (LRS, GRS, RAGRS, ZRS)"
  type        = string
  default     = "LRS"
}

variable "container_access_type" {
  description = "The access level of the Blob Container (private, blob, or container)"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "A map of tags to assign to the Storage Account and Blob Container"
  type        = map(string)
  default     = {}
}
