# network module for creating virtual network, subnets, and network security group(mostly reused from previous assignment)
# Local variables for commonly used values
locals {
  local_rgname = var.rgname   # The name of the resource group to deploy resources
  location     = var.location # Azure region where resources will be deployed
  tags         = var.tags     # Tags for categorizing resources
}

# Virtual Network resource creation
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.environment}-${var.vnet_name}" # Unique name for the virtual network based on the environment
  resource_group_name = local.local_rgname                    # References the resource group from local variables
  location            = local.location                        # Uses the deployment location from local variables
  address_space       = var.address_space                     # CIDR block defining the address space for the VNet
  tags                = local.tags                            # Tags applied to the VNet
}

# Network Security Group creation for controlling network traffic
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.environment}-${var.nsg_name}" # Unique name for the NSG based on the environment
  location            = local.location                       # Uses the deployment location from local variables
  resource_group_name = local.local_rgname                   # References the resource group from local variables
  tags                = local.tags                           # Tags applied to the NSG

  # Dynamic block to iterate over and create multiple security rules
  dynamic "security_rule" {
    for_each = var.security_rules # Iterates over each security rule provided in the variable
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

# Associating the NSG with the webapp subnet
resource "azurerm_subnet_network_security_group_association" "nsg_subnet_assoc" {
  subnet_id                 = azurerm_subnet.webapp_subnet.id       # ID of the webapp subnet
  network_security_group_id = azurerm_network_security_group.nsg.id # ID of the created NSG
}

# Subnet creation for the webapp service
resource "azurerm_subnet" "webapp_subnet" {
  name                 = "${var.environment}-${var.website_subnet_name}" # Unique name for the webapp subnet
  resource_group_name  = local.local_rgname                              # References the resource group from local variables
  virtual_network_name = azurerm_virtual_network.vnet.name               # Associates the subnet with the created VNet
  address_prefixes     = var.website_subnet_prefix                       # CIDR block defining the address space for the subnet
}

# Subnet creation for the SQL database
resource "azurerm_subnet" "db_subnet" {
  name                 = "${var.environment}-${var.db_subnet_name}" # Unique name for the database subnet
  resource_group_name  = local.local_rgname                         # References the resource group from local variables
  virtual_network_name = azurerm_virtual_network.vnet.name          # Associates the subnet with the created VNet
  address_prefixes     = var.db_subnet_prefix                       # CIDR block defining the address space for the subnet
}
