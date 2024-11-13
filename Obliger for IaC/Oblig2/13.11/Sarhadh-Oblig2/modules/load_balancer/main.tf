# Creates a public IP for the load balancer with a static allocation and standard SKU
resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.environment}-lb-public-ip" # Unique name for the public IP resource, prefixed by the environment
  location            = var.location                      # Azure region for the public IP
  resource_group_name = var.resource_group_name           # Resource group where the public IP will be deployed
  allocation_method   = "Static"                          # Specifies that the IP will be statically allocated
  sku                 = "Standard"                        # Defines the SKU tier for the public IP (Standard for high availability)

  tags = var.tags # Tags for resource management and organization
}

# Creates a load balancer with a standard SKU and frontend IP configuration
resource "azurerm_lb" "load_balancer" {
  name                = "${var.environment}-load-balancer" # Unique name for the load balancer, prefixed by the environment
  location            = var.location                       # Azure region for the load balancer
  resource_group_name = var.resource_group_name            # Resource group where the load balancer will be deployed
  sku                 = "Standard"                         # SKU tier for the load balancer (Standard for better performance and availability)

  # Configures the frontend IP for the load balancer
  frontend_ip_configuration {
    name                 = "PublicIPAddress"                 # Name for the frontend configuration
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id # Reference to the public IP created above
  }

  tags = var.tags # Tags for resource management and organization
}
