variable "automation_account_name" {
    type        = string
    description = "Name of Resource group where the automation account resides."
}

variable "automation_account_rg" {
    type        = string
    description = "Specifies the rg of the automation account."
}

variable "module_names" {
    type        = list
    description = " Specifies the name of the Module."
}

variable "uri" {
    type        = list
    description = "The uri of the module content (zip or nupkg)."
    default     = ["https://devopsgallerystorage.blob.core.windows.net/packages/xactivedirectory.2.19.0.nupkg"]
}