variable "caller_name" {
    type = string
    description = "Local name of the VM or load balancer or other names of using this public ip."
}

variable "public_ip_num" {
    type = string
    description = "Number of public IPs to assign corresponding to one IP per vm. Set to 0 to not assign any public IP addresses."
    default = "1"
}

variable "location" {
    type = string
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
    type = string
    description = "Specifies the name of the Resource Group."
}

variable "allocation_method" {
    type = string
    description = "Defines the allocation method for this IP address. Accepted values are static and dynamic."
    default = "Static"
}

variable "sku" {
    type = string
    description = "The SKU of the Public IP. Accepted values are Basic and Standard."
    default = "Basic"
}

variable "tags" {
    type        = map
    description = "A map of the tags to use on the resources that are deployed with this module."
}
