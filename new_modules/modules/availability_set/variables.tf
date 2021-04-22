variable "name" {
  type        = string
  description = "Specifies the name of the Availability Set."
}

variable "location" {
  type        = string
  description = "Specifies the location of the AvailabilitySet."
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name."
}

variable "platform_fault_domain_count" {
  type        = string
  description = "Specifies the number of fault domains that are used."
  default     = "2"
}

variable "platform_update_domain_count" {
  type        = string
  description = "Specifies the number of update domains that are used. Defaults to 5."
  default     = "5"
}

variable "tags" {
  type        = map(any)
  description = "Define default tags"
}