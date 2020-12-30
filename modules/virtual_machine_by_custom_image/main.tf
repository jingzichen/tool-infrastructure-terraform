resource "azurerm_virtual_machine" "virtual_machine" {
    count                 = "${var.vm_count}"
    name                  = "${var.name}${count.index + 1}"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    network_interface_ids = ["${element(var.network_interface_ids, count.index)}"]
    vm_size               = "${var.vm_size}"
    availability_set_id   = "${var.availability_set_id}"

    storage_image_reference {      
        id        = "${var.custom_image}"
    }

    storage_os_disk {
        name              = "${var.name}${count.index + 1}-${var.os_disk_name}"
        caching           = "${var.os_disk_caching}"
        create_option     = "${var.os_disk_create_option}"
        disk_size_gb      = "${var.os_disk_size_gb}"
        managed_disk_type = "${var.os_managed_disk_type}"
    }
    
    dynamic "storage_data_disk" {
        for_each = "${var.settings}"
        content {
            name              = "${var.name}${count.index + 1}-datadisk-${storage_data_disk.key + 1}"
            create_option     = "${storage_data_disk.value["data_disk_create_option"]}"
            disk_size_gb      = "${storage_data_disk.value["data_disk_size_gb"]}"
            managed_disk_type = "${storage_data_disk.value["managed_disk_type"]}"
            lun               = "${storage_data_disk.key}"
        }
    }

    delete_os_disk_on_termination    = "${var.delete_os_disk_on_termination}"
    delete_data_disks_on_termination = "${var.delete_data_disks_on_termination}"
    
    os_profile {
        computer_name  = "${var.name}${count.index + 1}"
        admin_username = "${var.os_profile_username}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     =  "/home/${var.os_profile_username}/.ssh/authorized_keys"
            key_data = "${var.ssh_keys_key_data}"
        }
    }

    lifecycle {
        ignore_changes = ["storage_data_disk"]
    }

    tags = "${var.tags}"

}