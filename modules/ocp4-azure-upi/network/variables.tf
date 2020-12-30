variable "resource_group_name" {
    type        = "string"
    description = "Resource group for the deployment"
}

variable "location" {
    type        = "string"
    description = "The target Azure region for the cluster."
}

variable "vnet_name" {
    type = "string"
}

variable "subnet_names" {
    type        = "list"
}

variable "subnet_cidrs" {
    type        = "list"
}

variable "cluster_name" {
    type = "string"
}
