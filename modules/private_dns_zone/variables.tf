variable "name" {
    type        = string
    description = "The name of the Private DNS Zone. Must be a valid domain name."
}

variable "resource_group_name" {
    type        = string
    description = "Specifies the resource group where the resource exists."
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}