variable "name" {
    description = "The name of the redis service"
    type        = string
}

variable "location" {
    description = "Region where the resources are created."
    type        = string
}

variable "resource_group_name" {
    description = "The name of the resource group in which the resources will be created."
    type        = string
}

variable "capacity" {
    description = "The size of the Redis cache to deploy. Valid values for a SKU family of C (Basic/Standard) are 0, 1, 2, 3, 4, 5, 6, and for P (Premium) family are 1, 2, 3, 4y"
    type        = string
}

variable "family" {
    description = " The SKU family/pricing group to use. Valid values are C (for Basic/Standard SKU family) and P (for Premium)"
    type        = string
}

variable "sku_name" {
    description = "The SKU of Redis to use. Possible values are Basic, Standard and Premium."
    type        = string
}

variable "enable_non_ssl_port" {
    description = "(Optional) Enable the non-SSL port (6379) - disabled by default."
    type        = string
    default     = false
}

variable "private_static_ip_address" {
    description = "(Optional) The Static IP Address to assign to the Redis Cache when hosted inside the Virtual Network. Changing this forces a new resource to be created."
    type        = string
}

variable "shard_count" {
    description = "The number of Shards to create on the Redis Cluster."
    type        = string
}

variable "subnet_id" {
    description = "The ID of the Subnet within which the Redis Cache should be deployed. This Subnet must only contain Azure Cache for Redis instances without any other type of resources. Changing this forces a new resource to be created."
    type        = string
}

variable "tags" {
    description = "define default tags"
    type        = map
}

variable "enable_authentication" {
    description = "enable_authentication can only be set to false if a subnet_id is specified. and only works if there aren't existing instances within the subnet with enable_authentication set to true."
    type        = string
    default     = false
}

