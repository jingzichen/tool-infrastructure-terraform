variable "resource_group_name" {
    description = "define default azure resource group name."
    type        = string
}

variable "location" {
    description = "define default azure location."
    type        = string
}

variable "disk_count" {
    description = "define default azure disk count."
    type        = string
}

variable "disk_name" {
    description = "define default azure disk name."
    type        = string
}

variable "storage_account_type" {
    description = "define default azure storage account type."
    type        = string
}

variable "create_option" {
    description = "define default azure create option."
    type        = string
}

variable "disk_size_gb" {
    description = "define default azure disk size gb."
    type        = string
}

variable "tags" {
    description = "define default tags"
    type        = map
}