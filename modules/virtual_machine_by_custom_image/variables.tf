variable "vm_count" {
    type = string
    description = "The count parameter on vm resources can simplify configurations and let you scale vm resources."
    default = 1
}

variable "name" {
    type = string
    description = "Specifies the name of the VM."
}

variable "resource_group_name" {
    type = string
    description = "Specifies the resource_group_name of the VM."
}

variable "location" {
    type = string
    description = "Specifies the location of the VM."
}

variable "vm_size" {
    type = string
    description = "Specifies the size of the virtual machine."
}

variable "network_interface_ids" {
    type = list
    description = "Specifies the network interface ids."
}

variable "availability_set_id" {
    type = string
    description = "The virtual Availability Set ID."
    default = ""
}

variable "custom_image" {
    description = "The managed image ID."
}

variable "os_disk_name" {
    type = string
    description = "Specifies the name of the OS Disk."
    default = "os-disk"
}

variable "os_disk_caching" {
    type = string
    description = "Specifies the caching requirements."
    default = "ReadWrite"
}

variable "os_disk_create_option" {
    type = string
    description = "Specifies how the virtual machine should be created. Possible values are attach and FromImage."
    default = "FromImage"
}

variable "os_disk_size_gb" {
    type = string
    description = "Specifies Data OS Storage Account size."
    default = "30"
}

variable "os_managed_disk_type" {
    type = string
    description = "Specifies OS Disk Storage Account type"
    default = "Standard_LRS"
}

variable "os_profile_username" {
    type = string
    description = "Specifies the name of the administrator account."
    default = "azureuser"
}

variable "ssh_keys_key_data" {
    type = string
    description = "Specifies a collection of path and key_data to be placed on the virtual machine."
}

variable "tags" {
    type        = map
    description = " A map of the tags to use on the resources that are deployed with this module."
}

variable "delete_os_disk_on_termination"{
    type = bool
    description = "If true, delete the OS disk automatically when deleting the VM."
    default = "true"
}

variable "delete_data_disks_on_termination" {
    type = bool
    description = "If true, delete the data disks automatically when deleting the VM."
    default = "true"
}

variable "settings" {
    type = list(map(string))
    description = "Use dynamic blocks to repeatable nested blocks."
    default = [
        {
            data_disk_create_option = "Empty"
            data_disk_size_gb = "30"
            managed_disk_type = "Standard_LRS"
        },
        {
            data_disk_create_option = "Empty"
            data_disk_size_gb = "512"
            managed_disk_type = "Standard_LRS"
        },
    ]
}