variable "resource_group_name" {
    type        = "string"
    description = "Resource group for the deployment"
}

variable "cluster_name" {
    type        = "string"
    description = "The cluster name of openshift"
}

variable "base_domain" {
    type        = "string"
    description = "The base domain used for private records"
}

variable "vnet_id" {
    type        = "string"
    description = "The vnet ip used to link to public dns"
}

