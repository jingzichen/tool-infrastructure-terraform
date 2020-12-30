variable "disk_resource_group_name" {
    type        = string
    description = "Name of Resource group where the managed data disks resides"
}

variable "managed_disk_names" {
    type        = list
    description = "Names of the disks to snapshot provided in list format"
}

variable "version_name" {
    type        = string
    default     = "1.0"
    description = "Snapshot version"
}

variable "location" {
    type        = string
    description = "Specifies the location of the snapshot."
}

variable "resource_group_name" {
    type        = string
    description = "Resource Group Name."
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}