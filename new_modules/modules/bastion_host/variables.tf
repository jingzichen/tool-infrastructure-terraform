variable "name" {
  description = "(Required) Specifies the name of the Bastion Host. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Bastion Host."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists."
  type        = string
}

variable "subnet_id" {
  description = "(Required) Reference to a subnet in which this Bastion Host has been created."
  type        = string
}

variable "public_ip_address_id" {
  description = "(Required) Reference to a Public IP Address to associate with this Bastion Host."
  type        = string
}

variable "tags" {
  type        = map(any)
  description = " A mapping of tags to assign to the resource."
}