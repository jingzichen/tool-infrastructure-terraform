variable "resource_group_name" {
  type        = "string"
  description = "Resource group for the deployment"
}

variable "cluster_name" {
  type        = "string"
}

variable "base_domain" {
  description = "The base domain used for public records"
  type        = "string"
}

variable "cluster_public_ip" {
  description = "External API's LB fqdn"
  type        = "string"
}
