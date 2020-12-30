resource "azurerm_backup_policy_vm" "daily_policy" {
    name                = var.name
    resource_group_name = var.resource_group_name
    recovery_vault_name = var.recovery_vault_name
    timezone = "Taipei Standard Time"

    backup {
        frequency = "Daily"
        time      = var.time
    }

    retention_daily {
        count = var.keep_count
    }
}
