variable "instance_num" {
  description = "Specify the number of vm instances"
  type        = number
  default     = 1
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "caller_name" {
  description = "Local name of the VM or other names of using this interface."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group."
  type        = string
}

variable "subnet_id" {
  type        = string
  description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "private_ip_address_allocation" {
  description = "Defines how a private IP address is assigned. Options are Static or Dynamic."
  type        = string
  default     = "Dynamic"
}

variable "private_ip_address" {
  description = "Static IP Address."
  type        = list(any)
  default     = []
}

variable "public_ip_address_id" {
  description = "The ID of a Public IP Address which should be associated with the NIC."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(any)
}