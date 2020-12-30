variable "automation_account_name" {
    type        = string
    description = "Name of Resource group where the automation account resides."
}

variable "automation_account_rg" {
    type        = string
    description = "Specifies the rg of the automation account."
}

variable "schedule_name" {
    type        = string
    description = "Specifies the name of the Schedule."
}

variable "frequency" {
    type        = string
    description = "The number of frequencys between runs.The number of frequencys between runs."
}

variable "interval" {
    type        = string
    description = "The number of frequencys between runs."
}

variable "timezone" {
    type        = string
    description = "The timezone of the start time."
    default     = "Taipei Standard Time"
}

variable "description" {
    type        = string
    description = "A description for this Schedule."
    default     = "A description for this Schedule."
}

variable "runbook_name" {
    type        = string
    description = "The name of a Runbook to link to a Schedule."
}