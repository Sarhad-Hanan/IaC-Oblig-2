# outputs the key vault id
output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}