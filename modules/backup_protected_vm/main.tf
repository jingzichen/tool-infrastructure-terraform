resource "azurerm_backup_protected_vm" "vm" {
    resource_group_name = var.resource_group_name
    recovery_vault_name = var.recovery_vault_name
    source_vm_id        = var.source_vm_id
    backup_policy_id    = var.backup_policy_id
}