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

variable "public_ip_dns" {
    type = list
    description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
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
