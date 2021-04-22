variable "caller_name" {
  description = "Who uses this public ip prefix."
  type        = string
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "Specifies the name of the Resource Group."
  type        = string
}

variable "zones" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  type        = list(any)
  default = []
}

variable "prefix_length" {
  description = "Specifies the number of bits of the prefix."
  type        = number
  default     = 28 # 16 addresses
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(any)
}