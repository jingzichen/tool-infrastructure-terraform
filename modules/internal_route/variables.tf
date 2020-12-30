#This is Lafite resource group
variable "resource_group_name" {
    description = "define default azure resource group name."
    type        = string
}

#This is Lafite resource location
variable "resource_group_location" {
    description = "define default azure resource group location."
    type        = string
}

#This is Lafite vnet
variable "target_peering_vnet" {
    description = "name for target peering vnet"
    type        = string
}

variable "target_lb_subnet" {
    description = "it is lafite router subnet ,other peering vnet will access this subnet loadblance"
    type        = string
}

variable "target_lb_frontend_ip" {
    description = "it is lafite internal lb ip. other peering vnet will access this ip assuming the router is used"
    type        = string
}

variable "domain" {
    description = "DNS name of lafite"
    type        = string
}

variable "record" {
    description = "internal route DNS record"
    type        = string
}

variable "ttl" {
    description = "ttl of internal route DNS record"
    type        = string
}


variable "http_probe_port" {
    description      = "port of internal LB http probe"
    default          = 32080
    type             = string
}

variable "https_probe_port" {
    description = "port of internal LB https probe"
    default     = 32443
    type = string
}

variable "lb_name" {
    description = "internal LB name"
    default     = "internal_lb"
    type        = string
}

variable "frontend_ip_name" {
    description = "internal LB name"
    default     = "internal-front-ip"
    type        = string
}

variable "private_ip_address_allocation" {
    description = "private ip address allocation"
    default     = "Static"
    type        = string
}

variable "azurerm_lb_backend_address_pool_name" {
    description = "lb backend address pool name"
    default     = "route-http-probe"
    type        = string
}

variable "lb_http_rule_name" {
    description = "lb backend address pool name"
    default     = "route-http-probe"
    type        = string
}

variable "lb_http_rule_protocol" {
    description = "lb http rule protocol"
    default     = "Tcp"
    type        = string
}

variable "lb_https_rule_name" {
    description = "lb backend address pool name"
    default     = "route-https-probe"
    type        = string
}

variable "lb_https_rule_protocol" {
    description = "lb https rule protocol"
    default     = "Tcp"
    type        = string
}

#Modify it ! that what do you want peering .
variable "peer_mapping_list" {
    description = "peeing namespace contain peeing vnet"
    type        = map(list(string))
}


locals {
  private_dns = {
    domain = var.domain
    record = var.record
    ttl    = var.ttl
  }
}

locals {
  association_list = flatten([
    for rg in keys(var.peer_mapping_list) : [
      for vn in var.peer_mapping_list[rg] : {
        resourceGroup = rg
        vnet          = vn
      }
    ]
  ])
}

#This private LB will be setting for internal route
locals {
  target_lb = {
    name = var.lb_name
    # Modify it ! Is is lafite router subnet . other peering vnet will access this subnet
    subnet           = var.target_lb_subnet
    http_probe_port  = var.http_probe_port
    https_probe_port = var.https_probe_port

    frontend_ip = {
      name = var.frontend_ip_name
      # Modify it ! Is is lafite internal lb ip. other peering vnet will access this ip assuming the router is used
      private_ip_address            = var.target_lb_frontend_ip
      private_ip_address_allocation = var.private_ip_address_allocation
    }
  }
}
