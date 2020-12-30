variable "resource_group_name" {
    description = "define default azure resource group name."
    type        = string
}

variable "name" {
    description = "Specifies the name of the Backup Policy."
    type        = string
}

variable "recovery_vault_name" {
    description = "Specifies the name of the Recovery Services Vault to use."
    type        = string
}

variable "time" {
    description = "The time of day to perform the backup in 24hour format."
    type        = string
}

variable "keep_count" {
    description = "The number of daily backups to keep. Must be between 1 and 9999"
    type        = number
}