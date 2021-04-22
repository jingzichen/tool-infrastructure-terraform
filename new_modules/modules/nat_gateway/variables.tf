variable "public_ip_count" {
  description = "The number of public ip."
  type        = number
  default     = 1
}

variable "caller_name" {
  description = "Local name of the VM or load balancer or other names of using this public ip."
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

variable "allocation_method" {
  description = "Defines the allocation method for this IP address. Accepted values are static and dynamic."
  type        = string
  default     = "Static"
}

variable "ip_addr" {
  description = "(Required) Object with the settings for public IP deployment"
}

# Example of ip_addr configuration object
# ip_addr = {
#       #properties below are optional
#       sku                 = "Standard"                        #defaults to Basic
#       ip_version          = "IPv4"                            #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
#       dns_prefix          = "arnaudmytestdeeee"
#       timeout             = 15                                #TCP timeout for idle connections. The value can be set between 4 and 30 minutes.
#       zones               = [1]                               #1 zone number, IP address must be standard, ZoneRedundant argument is not supported in provider at time of writing
#       #reverse_fqdn        = ""
#       #public_ip_prefix_id = "/subscriptions/783438ca-d497-4350-aa36-dc55fb0983ab/resourceGroups/uqvh-hub-ingress-net/providers/Microsoft.Network/publicIPPrefixes/myprefix"
#       #refer to the prefix and check sku types are same in IP and prefix
# }

variable "zones" {
  description = "The SKU of the Public IP. Accepted values are Basic and Standard."
  type        = list(any)
  default     = [1]
}

variable "nat_gateway_sku" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = string
  default     = "Standard"
}

variable "idle_timeout_in_minutes" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = string
  default     = 4
}

# variable "associated_public_ip_ids" {
#   description = "A list of Public IP Address ID's which should be associated with the NAT Gateway resource."
#   type        = list(any)
# }

variable "associated_subnet_ids" {
  description = "The ID of the Subnet. Changing this forces a new resource to be created."
  type        = list(any)
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  type        = map(any)
}