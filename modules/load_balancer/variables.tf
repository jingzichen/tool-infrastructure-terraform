variable "caller_name" {
    type = string
    description = "Specifies the caller who uses LB module"
}

variable "resource_group_name" {
    type = string
    description = "The name of the Resource Group in which to create the Load Balancer."
}

variable "type" {
    type = string
    description = "Ability to specify public or private loadbalancer."
    default = "public"
}

variable "location" {
    type = string
    description = "Specifies the supported Azure Region where the Load Balancer should be created."
    default = "southeastasia"
}

variable "sku" {
    type = string
    description = "The SKU of the Azure Load Balancer. Accepted values are Basic and Standard."
    default = "Standard"
}

variable "public_ip_address_id" {
    type = list
    description = "The ID of a Public IP Address which should be associated with the Load Balancer."
    default = []
}

variable "subnet_id" {
    type        = string
    description = "The ID of the Subnet which should be associated with the IP Configuration."
    default     = null
}

variable "private_ip_address" {
    type        = string
    description = "Private IP Address to assign to the Load Balancer. The last one and first four IPs in any range are reserved and cannot be manually assigned."
    default     = null
}

variable "private_ip_address_allocation" {
    type        = string
    description = "The allocation method for the Private IP Address used by this Load Balancer. Possible values as Dynamic and Static."
    default     = "Dynamic"
}

# variable "zones" {   ### [TODO] Check the availabe value ###
# 	type = list(string)
# 	description = "A list of Availability Zones which the Load Balancer's IP Addresses should be created in."
#   default = ["Zone-redundant"]
# }

variable "backend_rule" {
    type = list(object({
        name = string
        protocol = string
        frontend_port = number
        backend_port = number
        idle_timeout_in_minutes = number  # option, default is 4 minutes
        probe = map(any)  # Follow azurerm_lb_probe for configuration
  	}))
    description = "Specifies the details of the Backend Rule."
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}