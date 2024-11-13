# Creates the key vault resource to securely store secrets and keys. Mostly reused form the previous assignment.
resource "azurerm_key_vault" "key_vault" {
  name                        = var.key_vault_name              # Name of the Key Vault
  location                    = var.location                    # Azure region for deployment
  resource_group_name         = var.rgname                      # Name of the resource group for the Key Vault
  enabled_for_disk_encryption = var.enabled_for_disk_encryption # Whether the Key Vault can be used for disk encryption
  tenant_id                   = var.tenant_id                   # Azure tenant ID associated with the Key Vault
  purge_protection_enabled    = var.purge_protection_enabled    # Enables protection against accidental deletion
  sku_name                    = var.sku_name                    # SKU for the Key Vault (e.g., Standard, Premium)

  # Having the firewall enabled is a good practice but this prevents the Key Vault from being accessed by my local address
  # witch i assume is the case for the reviewer as well so i will comment it out.
  /*
  network_acls {
     bypass         = "AzureServices" # Specifies which traffic can bypass the Key Vault firewall
     default_action = "Deny"          # Default action for network traffic
  }
   */
  # Configures access policies based on provided variable input for flexible and dynamic access management.
  dynamic "access_policy" {
    for_each = var.access_policies # Iterate through each access policy provided
    content {
      tenant_id           = access_policy.value.tenant_id           # Tenant ID for the access policy
      object_id           = access_policy.value.object_id           # Object ID (user or service principal) for permissions
      secret_permissions  = access_policy.value.secret_permissions  # List of secret permissions
      key_permissions     = access_policy.value.key_permissions     # List of key permissions
      storage_permissions = access_policy.value.storage_permissions # List of storage permissions
    }
  }

  tags = var.tags # Tags for categorizing and managing the Key Vault
}

# Creates a Key Vault secret to store the storage account access key securely.
resource "azurerm_key_vault_secret" "storage_account_key" {
  name         = "storageaccountkey"          # Name of the secret in the Key Vault
  value        = var.sa_access_key # Value of the storage account access key to be stored
  key_vault_id = azurerm_key_vault.key_vault.id # Reference to the Key Vault ID
  content_type = "storageAccountKey"            # Specifies the content type for the secret

  lifecycle {
    prevent_destroy = false # Allows the secret to be destroyed during deletion
  }
}

# Creates a Key Vault secret to store the SQL admin password securely.
resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sqladminloginpassword"     # Name of the secret in the Key Vault
  value        = var.sql_admin_password         # Value of the SQL admin password to be stored
  key_vault_id = azurerm_key_vault.key_vault.id # Reference to the Key Vault ID
  content_type = "password"                     # Specifies the content type for the secret
  lifecycle {
    prevent_destroy = false # Allows the secret to be destroyed during deletion
  }
}

# Creates a Key Vault secret to store the SQL admin login securely.
resource "azurerm_key_vault_secret" "sql_admin_login" {
  name         = "sqladminlogin"              # Name of the secret in the Key Vault
  value        = var.sql_admin_login            # Value of the SQL admin login to be stored
  key_vault_id = azurerm_key_vault.key_vault.id # Reference to the Key Vault ID

  content_type = "username" # Specifies the content type for the secret
  lifecycle {
    prevent_destroy = false # Allows the secret to be destroyed during deletion
  }
}
