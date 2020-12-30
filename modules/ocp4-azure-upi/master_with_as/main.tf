resource "azurerm_network_interface" "master" {
    count               = "${var.master_count}"
    name                = "${var.cluster_name}-master${count.index}-nic"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"

    ip_configuration {
        subnet_id                     = "${var.subnet_id}"
        name                          = "${var.nic_name}"
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface_backend_address_pool_association" "master" {
    count                   = "${var.master_count}"
    network_interface_id    = "${element(azurerm_network_interface.master.*.id, count.index)}"
    backend_address_pool_id = "${var.elb_backend_pool_id}"
    ip_configuration_name   = "${var.nic_name}" #must be the same as nic's ip configuration name.
}

resource "azurerm_network_interface_backend_address_pool_association" "master_internal" {
    count                   = "${var.master_count}"
    network_interface_id    = "${element(azurerm_network_interface.master.*.id, count.index)}"
    backend_address_pool_id = "${var.ilb_backend_pool_id}"
    ip_configuration_name   = "${var.nic_name}" #must be the same as nic's ip configuration name.
}

resource "azurerm_availability_set" "master" {
    name                         = "${var.cluster_name}-master-availability-set"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"
    platform_fault_domain_count  = "${var.platform_fault_domain_count}"
    platform_update_domain_count = "${var.platform_update_domain_count}"
    managed                      = true
}

resource "azurerm_virtual_machine" "master" {
    count                 = "${var.master_count}"
    name                  = "${var.cluster_name}-master-${count.index}"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    availability_set_id   = "${azurerm_availability_set.master.id}"
    network_interface_ids = ["${element(azurerm_network_interface.master.*.id, count.index)}"]
    vm_size               = "${var.vm_size}"

    tags                  = { "openshift": "master" }

    delete_os_disk_on_termination = true

    identity {
        type         = "UserAssigned"
        identity_ids = ["${var.identity}"]
    }

    storage_os_disk {
        name              = "${var.cluster_name}-master-${count.index}_OSDisk" # os disk name needs to match cluster-api convention
        caching           = "ReadOnly"  # The default caching of OS disk is ReadWrite, to provide higher performance, we change it to ReadOnly
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
        disk_size_gb      = "${var.os_volume_size}"
    }

    storage_image_reference {
        id = "${var.vm_image}"
    }

    //we don't provide a ssh key, because it is set with ignition.
    //it is required to provide at least 1 auth method to deploy a linux vm
    os_profile {
        computer_name  = "${var.cluster_name}-master-${count.index}"
        admin_username = "core"
        # The password is normally applied by WALA (the Azure agent), but this
        # isn't installed in RHCOS. As a result, this password is never set. It is
        # included here because it is required by the Azure ARM API.
        admin_password = "NotActuallyApplied!"
        custom_data    = "${var.ignition}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    boot_diagnostics {
        enabled     = true
        storage_uri = "${var.boot_diag_blob_endpoint}"
    }

   lifecycle {
       ignore_changes = [ "identity", "os_profile", "storage_data_disk", "storage_image_reference", "storage_os_disk" ]
   }
}

/**
 * Allow to ssh into masters from bastion-standalone1
 */
resource "azurerm_network_security_rule" "ssh_in" {
    name                        = "ssh_in"
    priority                    = 104
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefixes     = ["52.187.45.13"]
    destination_address_prefix  = "*"
    resource_group_name         = "${var.resource_group_name}"
    network_security_group_name = "${var.nsg_name}"
}