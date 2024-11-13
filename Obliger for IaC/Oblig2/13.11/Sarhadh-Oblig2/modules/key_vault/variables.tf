# Variable for the Key Vault name
variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

# Variable for the Resource Group name where the Key Vault will be deployed
variable "rgname" {
  description = "Name of the Azure Resource Group"
  type        = string
}

# Variable for the Azure region where resources will be deployed
variable "location" {
  description = "Azure region for the Key Vault"
  type        = string
}

# Variable for the tenant ID associated with Azure Active Directory
variable "tenant_id" {
  description = "Azure Active Directory tenant ID for Key Vault"
  type        = string
}

# Variable to enable or disable disk encryption for the Key Vault
variable "enabled_for_disk_encryption" {
  description = "Whether the Key Vault is enabled for disk encryption"
  type        = bool
  default     = false
}

# Variable to enable or disable purge protection for the Key Vault
variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled for the Key Vault"
  type        = bool
  default     = true
}

# Variable for specifying the SKU type of the Key Vault (e.g., Standard or Premium)
variable "sku_name" {
  description = "SKU Name for the Key Vault"
  type        = string
  default     = "standard"
}

# Variable for defining access policies for the Key Vault
variable "access_policies" {
  description = "List of access policies for the Azure Key Vault"
  type = list(object({
    tenant_id           = string       # Tenant ID for the access policy
    object_id           = string       # Object ID of the user or service principal
    secret_permissions  = list(string) # List of permissions for secrets
    key_permissions     = list(string) # List of permissions for keys
    storage_permissions = list(string) # List of permissions for storage
  }))
}

# Variable for the storage account access key (sensitive)
variable "sa_access_key" {
  description = "The access key for the Azure Storage Account (sensitive)"
  type        = string
  sensitive   = true
}

# Variable for tags to be applied to all resources
variable "tags" {
  description = "Tags to be applied to all resources."
  type        = map(string)
}

# Variable for the SQL Server admin password (sensitive)
variable "sql_admin_password" {
  description = "The password for the SQL Server admin account (sensitive)"
  type        = string
  sensitive   = true
}

# Variable for the SQL Server admin login (sensitive)
variable "sql_admin_login" {
  description = "The login for the SQL Server admin account"
  type        = string
  sensitive   = true
}
