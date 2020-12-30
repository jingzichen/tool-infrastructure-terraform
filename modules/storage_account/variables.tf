variable "resource_group_name" {
    description = "define default azure resource group name"
    type        = string
}

variable "location" {
    description = "define default azure resource group location"
    type        = string
}

variable "account_name" {
    description = "define default azure storage account name"
    type        = string
}

variable "account_tier" {
    description = "define default azure storage account tier"
    type        = string
}

variable "account_replication_type" {
    description = "define default azure storage account replication type"
    type        = string
}

variable "tags" {
    description = "define default tags"
    type        = map
}