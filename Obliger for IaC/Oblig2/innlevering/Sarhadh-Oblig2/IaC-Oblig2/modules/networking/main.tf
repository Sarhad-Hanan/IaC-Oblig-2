provider "azurerm" {
  features {}
}

# Random Name Generation for Load Balancer and Public IP
resource "random_pet" "lb_name" {
  length = 2
}

resource "random_id" "lb_public_ip" {
  byte_length = 8
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Subnets (dynamic count based on input)
resource "azurerm_subnet" "subnet" {
  count               = length(var.subnets)
  name                = var.subnets[count.index].name
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes    = [var.subnets[count.index].address_prefix]
}

# Public IP for Load Balancer
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.vnet_name}-public-ip-${random_id.lb_public_ip.hex}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer
resource "azurerm_lb" "app_lb" {
  name                = "${random_pet.lb_name.id}-${var.vnet_name}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  frontend_ip_configuration {
    name                 = "public-ip-config"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
  sku = var.load_balancer_sku
}

# Backend Pool for Load Balancer
resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  name                = "${var.vnet_name}-backend-pool"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.app_lb.id
}

# Health Probe for Load Balancer
resource "azurerm_lb_probe" "lb_health_probe" {
  name                = "${var.vnet_name}-health-probe"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.app_lb.id
  protocol            = "HTTP"
  port                = var.health_probe_port
  request_path        = var.health_probe_path
  interval_in_seconds = 5
  number_of_probes    = 2
}

# Load Balancer Rule for Web Traffic
resource "azurerm_lb_rule" "lb_rule" {
  name                            = "${var.vnet_name}-lb-rule"
  resource_group_name             = var.resource_group_name
  loadbalancer_id                 = azurerm_lb.app_lb.id
  protocol                        = "Tcp"
  frontend_port                   = var.load_balancer_frontend_port
  backend_port                    = var.load_balancer_backend_port
  frontend_ip_configuration_name  = "public-ip-config"
  backend_address_pool_id         = azurerm_lb_backend_address_pool.lb_backend_pool.id
  probe_id                        = azurerm_lb_probe.lb_health_probe.id
}
