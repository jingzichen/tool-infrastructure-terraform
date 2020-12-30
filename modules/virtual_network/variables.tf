variable "resource_group_name" {
    description = "Default resource group name that the network will be created in."
    type     = string
}

variable "location" {
    description = "The location/region where the core network will be created."
    type     = string
}

variable "vnet_name" {
    description = "Name of the vnet to create"
    type     = string
}

variable "address_space" {
    description = "The address space that is used by the virtual network."
    type     = string
}

variable "subnet_names" {
    description = "A list of public subnets inside the vNet."
    type        = list
    default     = []
}

variable "subnet_prefixes" {
    description = "The address prefix to use for the subnet."
    type        = list
    default     = []
}

variable "tags" {
    description = "Define default tags"
    type        = map
}

