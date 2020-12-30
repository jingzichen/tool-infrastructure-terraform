variable "resource_group_name" {
    description = "define default azure resource group name."
    type        = string
}

variable "location" {
    description = "define default azure location."
    type        = string
}

variable "name" {
    description = "define ignition name."
    type        = string
}

variable "cluster_name" {
    description = "define ignition name."
    type        = string
}

variable "ignition_storage_account_name" {
    description = "define sa name."
    type        = string
}

variable "storage_container_name" {
    description = "define ignition container name"
    type        = "string"
    default     = "ignitionconfigfile"
}

variable "primary_connection_string" {
    description = "define primary_connection_string."
    type        = string
}
