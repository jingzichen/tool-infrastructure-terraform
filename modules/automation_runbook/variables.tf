variable "automation_account_name" {
    type        = string
    description = "Name of Resource group where the automation account resides."
}

variable "automation_account_rg" {
    type        = string
    description = "Specifies the rg of the automation account."
}

variable "runbook_name" {
    type        = string
    description = "Specifies the name of the Runbook."
}

variable "location" {
    type        = string
    description = "Specifies the supported Azure location where the resource exists."
}

variable "resource_group_name" {
    type        = string
    description = "The name of the resource group in which the Runbook is created."
}

variable "log_verbose" {
    type        = bool
    description = "Verbose log option."
    default     = "true"
}

variable "log_progress" {
    type        = bool
    description = "Progress log option."
    default     = "true"
}

variable "description" {
    type        = string
    description = "A description for this credential."
}

variable "runbook_type" {
    type        = string
    description = "The type of the runbook."
    default     = "PowerShell"
}

variable "uri" {
    type        = string
    description = "The uri of the runbook content."
    default     = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/c4935ffb69246a6058eb24f54640f53f69d3ac9f/101-automation-runbook-getvms/Runbooks/Get-AzureVMTutorial.ps1"
}

variable "content" {
    type        = string
    description = "The desired content of the runbook."
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}