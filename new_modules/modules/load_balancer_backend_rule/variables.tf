variable "lb_name" {
  description = "Specifies the LB name"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Resource Group in which to create the Load Balancer."
  type        = string
}

variable "address_pool_name" {
  description = "Specifies the caller who uses LB module"
  type        = string
}

variable "frontend_ip_config_name" {
  description = " Specifies the name of the frontend ip configuration."
  type        = string
  default     = "default"
}

variable "backend_rule" {
  description = "Specifies the details of the Backend Rule."
  type = list(object({
    name                    = string
    protocol                = string
    frontend_port           = number
    backend_port            = number
    idle_timeout_in_minutes = number   # option, default is 4 minutes
    probe                   = map(any) # Follow azurerm_lb_probe for configuration
  }))
}
