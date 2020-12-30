variable "automation_account_count" {
    type        = string
    description = "Define default azure automation account count."
}

variable "automation_account_name" {
    type        = string
    description = "Specifies the name of the automation account."
}

variable "location" {
    type        = string
    description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
    type        = string
    description = "The name of the resource group in which the Automation Account is created."
}

variable "sku_name" {
    type        = string
    description = "Specifies the name of the automation account."
    default     = "Basic"
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}
