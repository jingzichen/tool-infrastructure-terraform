variable "vm_count" {
  description = "The count parameter on vm resources can simplify configurations and let you scale vm resources."
  type        = number
  default     = 1
}

variable "name" {
  description = "(Required) The name of the Linux Virtual Machine. "
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. "
  type        = string
}

variable "location" {
  description = "(Required) The Azure location where the Linux Virtual Machine should exist."
  type        = string
}

variable "size" {
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2."
  type        = string
}

variable "network_interface_ids" {
  description = "Specifies the network interface ids."
  type        = list(any)
}

variable "availability_set_id" {
  type        = string
  description = "The virtual Availability Set ID."
  default     = ""
}

variable "publisher" {
  description = "Specifies the publisher of the image used to create the virtual machine."
  type        = string
}

variable "offer" {
  description = "Specifies the offer of the image used to create the virtual machine. "
  type        = string
}

variable "sku" {
  description = "Specifies the SKU of the image used to create the virtual machine."
  type        = string
}

variable "image_version" {
  description = "Specifies the version of the image used to create the virtual machine."
  type        = string
  default     = "latest"
}

variable "os_disk_name" {
  description = "Specifies the name of the OS Disk."
  type        = string
  default     = "os-disk"
}

variable "caching" {
  description = "Specifies the caching requirements."
  type        = string
  default     = "ReadWrite"
}

variable "disk_size_gb" {
  description = "Specifies Data OS Storage Account size."
  type        = string
  default     = "30"
}

variable "storage_account_type" {
  description = "Specifies OS Disk Storage Account type"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "admin_username" {
  description = "Specifies the name of the administrator account."
  type        = string
  default     = "cloud-user"
}

variable "public_key" {
  description = "Specifies a collection of path and key_data to be placed on the virtual machine."
  type        = string
}

variable "tags" {
  description = " A map of the tags to use on the resources that are deployed with this module."
  type        = map(any)
}
