# Variable for defining the deployment environment (e.g., dev, staging, prod)
variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
}

# Variable for specifying the name of the resource group to deploy resources into
variable "rgname" {
  description = "The name of the resource group"
  type        = string
}

# Variable to define the Azure region where resources will be deployed
variable "location" {
  description = "The Azure region for resource deployment"
  type        = string
}

# Variable for the name of the virtual network
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-operaterraas" # Default value for the virtual network name
}

# Variable for the name of the subnet used for the web application
variable "website_subnet_name" {
  description = "The name of the subnet used for the application"
  type        = string
  default     = "app-subnet" # Default value for the web application subnet name
}

# Variable for the name of the subnet used for the database
variable "db_subnet_name" {
  description = "The name of the subnet used for the database"
  type        = string
  default     = "db-subnet" # Default value for the database subnet name
}

# Variable defining the address space for the virtual network
variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"] # Default CIDR block for the virtual network
}

# Variable for the address prefix of the web application subnet
variable "website_subnet_prefix" {
  description = "The address prefix for the webapp service subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"] # Default CIDR block for the web application subnet
}

# Variable for the address prefix of the database subnet
variable "db_subnet_prefix" {
  description = "The address prefix for the database subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"] # Default CIDR block for the database subnet
}

# Variable for the name of the Network Security Group (NSG)
variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
  default     = "nsg-operaterraas" # Default name for the NSG
}

# Variable for defining security rules within the NSG
variable "security_rules" {
  description = "List of security rules for the NSG"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "allow-ssh"
      priority                   = 100              # Rule priority
      direction                  = "Inbound"        # Direction of traffic
      access                     = "Allow"          # Permit or deny traffic
      protocol                   = "Tcp"            # Protocol type
      source_port_range          = "*"              # Source port range
      destination_port_range     = "22"             # Destination port range (SSH)
      source_address_prefix      = "192.168.1.0/24" # Source IP range
      destination_address_prefix = "*"              # Destination IP range
    }
  ] # Default security rule to allow SSH access
}

# Variable for tags to be applied to resources for organization and management
variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
}
