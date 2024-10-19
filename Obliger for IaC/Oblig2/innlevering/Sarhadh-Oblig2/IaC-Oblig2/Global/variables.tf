variable "remote_state_resource_group_name" {
  description = "The name of the Resource Group for remote state storage"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the Storage Account for remote state storage"
  type        = string
}

variable "container_name" {
  description = "The name of the Blob Container for remote state storage"
  type        = string
}

variable "location" {
  description = "The location/region where the Storage Account and Blob Container will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}
