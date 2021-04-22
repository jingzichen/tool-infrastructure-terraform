variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the core network will be created."
  type        = string
}

variable "security_group_name" {
  description = "Network security group name"
  type        = string
}

# [priority, direction, access, protocol, source_port_range, destination_port_range, description]"
# All the fields are required.
variable "custom_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Define default tags"
  type        = map(any)
}