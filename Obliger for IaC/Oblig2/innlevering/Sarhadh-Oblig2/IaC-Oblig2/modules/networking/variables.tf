variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the Virtual Network."
  type        = list(string)
}

variable "location" {
  description = "The location/region where the Virtual Network is created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group where the Virtual Network will be created."
  type        = string
}

variable "subnets" {
  description = "List of subnets to be created."
  type = list(object({
    name          = string
    address_prefix = string
  }))
}

variable "load_balancer_sku" {
  description = "The SKU of the Load Balancer (Standard or Basic)"
  type        = string
  default     = "Standard"
}

variable "load_balancer_frontend_port" {
  description = "The frontend port for the Load Balancer"
  type        = number
  default     = 80
}

variable "load_balancer_backend_port" {
  description = "The backend port for the Load Balancer"
  type        = number
  default     = 80
}

variable "health_probe_port" {
  description = "The port used by the Load Balancer health probe"
  type        = number
  default     = 80
}

variable "health_probe_path" {
  description = "The request path used by the Load Balancer health probe"
  type        = string
  default     = "/"
}
