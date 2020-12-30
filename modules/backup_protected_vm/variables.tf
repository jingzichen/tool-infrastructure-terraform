variable "resource_group_name" {
    description = "Define default azure resource group name."
    type        = string
}

variable "recovery_vault_name" {
    description = "Specifies the name of the Recovery Services Vault to use. "
    type        = string
}

variable "source_vm_id" {
    description = "Specifies the ID of the VM to backup. "
    type        = string
}

variable "backup_policy_id" {
    description = "Specifies the id of the backup policy to use."
    type        = string
}