module "cassandra_vault" {
    source = "./modules/recovery_services_vault"

    resource_group_name = var.resource_group_name
    location            = var.location
    name                = local.backup.cassandra_vault.name
    sku                 = local.backup.cassandra_vault.sku

    tags                = local.backup.common_settings.tags
}

module "cassandra_backup_policy" {
    source = "./modules/backup_policy_vm"

    resource_group_name = var.resource_group_name
    name                = local.backup.cassandra_backup_policy.name
    recovery_vault_name = module.cassandra_vault.name
    time                = local.backup.cassandra_backup_policy.time
    keep_count          = local.backup.cassandra_backup_policy.keep_count
}

module "protected_cassandra1" {
    source = "./modules/backup_protected_vm"

    resource_group_name = var.resource_group_name
    recovery_vault_name = module.cassandra_vault.name
    source_vm_id        = module.cassandra_virtual_machine.id[0]
    backup_policy_id    = module.cassandra_backup_policy.id
}

module "protected_cassandra2" {
    source = "./modules/backup_protected_vm"

    resource_group_name = var.resource_group_name
    recovery_vault_name = module.cassandra_vault.name
    source_vm_id        = module.cassandra_virtual_machine.id[1]
    backup_policy_id    = module.cassandra_backup_policy.id
}

module "protected_cassandra3" {
    source = "./modules/backup_protected_vm"

    resource_group_name = var.resource_group_name
    recovery_vault_name = module.cassandra_vault.name
    source_vm_id        = module.cassandra_virtual_machine.id[2]
    backup_policy_id    = module.cassandra_backup_policy.id
}