variable "caller_name" {
    type = string
    description = "Local name of the VM or other names of using this interface."
}

variable "location" {
    type = string
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
    type = string
    description = "Specifies the name of the Resource Group."
}

variable "network_security_group_id" {
    type = string
    description = "Specifies the id of the network security group."
}

variable "subnet_id" {
    type = string
    description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "instance_num" {
    type = string
    description = "Specify the number of vm instances"
    default = "1"
}

# Note, because azurerm_network_interface_backend_address_pool_association could only use map / list as
# condition in count. Therefore, if a network interface needs to associate with a backend pool, please give the
# variable as following:
#
#    backend_address_pool_id = {
#        "id" = "${var.lb_backend_address_pool_id}"
#    }
#

variable "private_ip_address_allocation" {
    type = string
    description = "Defines how a private IP address is assigned. Options are Static or Dynamic."
    default = "Dynamic"
}

variable "private_ip_address" {
    type = list
    description = "Static IP Address."
    default = []
}

variable "backend_address_pool_id" {
    type = map
    description = "The ID of the Load Balancer Backend Address Pool which this Network Interface which should be connected to."
    default = {}
}

variable "tags" {
    type        = map
    description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "public_ip_address_id" {
    type = list
    description = "The ID of a Public IP Address which should be associated with the NIC."
    default = []
}