variable "location" {
    type        = "string"
    description = "The region for the deployment."
}

variable "resource_group_name" {
    type        = "string"
    description = "The resource group name for the deployment."
}

variable "cluster_name" {
    type = "string"
}

variable "vm_size" {
    type = "string"
}

variable "vm_image" {
    type        = "string"
    description = "The resource id of the vm image used for masters."
}

variable "identity" {
    type        = "string"
    description = "The user assigned identity id for the vm."
}

variable "master_count" {
    type = "string"
}

variable "elb_backend_pool_id" {
    type = "string"
}

variable "ilb_backend_pool_id" {
    type = "string"
}

variable "subnet_id" {
    type        = "string"
    description = "The subnet to attach the masters to."
}

variable "os_volume_size" {
    type        = "string"
    description = "The size of the volume in gigabytes for the root block device."
    default     = "100"
}

variable "boot_diag_blob_endpoint" {
    type        = "string"
    description = "the blob endpoint where machines should store their boot diagnostics."
}

variable "ignition" {
    type = "string"
}

variable "nic_name" {
    type        = "string"
    description = "the master interface name"
}

variable "nsg_name" {
    type        = "string"
}

