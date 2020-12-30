output "name" {
    description = "Specifies the name of the Recovery Services Vault."
    value       = azurerm_recovery_services_vault.vault.name
}
output "id" {
    description = "The ID of the Recovery Services Vault."
    value       = azurerm_recovery_services_vault.vault.id
}
