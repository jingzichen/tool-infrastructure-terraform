variable "caller_name" {
  type        = string
  description = "Local name of the VM or load balancer or other names of using this public ip."
}

variable "public_ip_num" {
  type        = string
  description = "Number of public IPs to assign corresponding to one IP per vm. Set to 0 to not assign any public IP addresses."
  default     = "1"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the Resource Group."
}

variable "allocation_method" {
  type        = string
  description = "Defines the allocation method for this IP address. Accepted values are static and dynamic."
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

variable "tags" {
  type        = map(any)
  description = "A map of the tags to use on the resources that are deployed with this module."
}