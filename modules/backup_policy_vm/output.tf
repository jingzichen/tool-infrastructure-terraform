output "id" {
    description = "The ID of the VM Backup Policy."
    value       = azurerm_backup_policy_vm.daily_policy.id
}
