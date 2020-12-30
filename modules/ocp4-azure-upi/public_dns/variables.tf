variable "resource_group_name" {
    type        = "string"
    description = "Resource group for the deployment"
}

variable "base_domain" {
    description = "The base domain used for public records"
    type        = "string"
}