variable "resource_group_name" {
    type        = "string"
    description = "Resource group for the deployment"
}

variable "dns_zone_name" {
    type        = "string"
    description = "Specifies the Private DNS Zone where the resource exists"
}

variable "internal_lb_ip" {
    description = "External API's LB Ip address"
    type        = "string"
}

variable "etcd_count" {
    description = "The number of etcd members."
    type        = "string"
}

variable "etcd_ip_addresses" {
    description = "List of string IPs for machines running etcd members."
    type        = list
    default     = []
}