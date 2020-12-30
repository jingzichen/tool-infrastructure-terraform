variable "resource_group_name" {
    description = "define default azure resource group name."
    type        = string
}

variable "location" {
    description = "define default azure location."
    type        = string
}

variable "name" {
    description = "Specifies the name of the Recovery Services Vault."
    type        = string
}

variable "sku" {
    description = "Sets the vault's SKU. Possible values include: Standard, RS0."
    type        = string
}

# variable "soft_delete" {
#     description = "Is soft delete enable for this Vault? Defaults to true."
#     type        = bool
#     default     = true
# }

variable "tags" {
    description = "A mapping of tags to assign to the resource."
    type        = map
}