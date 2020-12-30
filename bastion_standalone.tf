module "bastion_standalone_network_security_group" {
    source              = "./modules/network_security_group"

    security_group_name = "${local.bastion_standalone.common_settings.tags.role}"
    resource_group_name = "${module.resource_group.name}"
    location            = "${module.resource_group.location}"
    tags                = "${local.bastion_standalone.common_settings.tags}"
    custom_rules        = "${local.bastion_standalone.nsg_settings.custom_rules}"
}

module "bastion_standalone_public_ip" {
    source              = "./modules/public_ip_without_dns"

    public_ip_num       = "${local.bastion_standalone.pip_settings.public_ip_num}"
    caller_name         = "${local.bastion_standalone.common_settings.tags.role}"
    location            = "${module.resource_group.location}"
    resource_group_name = "${module.resource_group.name}"
    allocation_method   = "${local.bastion_standalone.pip_settings.allocation_method}"
    tags                = "${local.bastion_standalone.common_settings.tags}"
}

module "bastion_standalone_network_interface" {
    source                    = "./modules/network_interface"

    instance_num              = "${var.ashely_bastion_standalone_count}"
    caller_name               = "${local.bastion_standalone.common_settings.tags.role}"
    location                  = "${module.resource_group.location}"
    resource_group_name       = "${module.resource_group.name}"
    network_security_group_id = "${module.bastion_standalone_network_security_group.network_security_group_id}"
    public_ip_address_id      = "${module.bastion_standalone_public_ip.public_ip_id}"
    subnet_id                 = "${data.azurerm_subnet.develop_subnet[index(module.develop_vnet.subnet_names, "develop")].id}"
    tags                      = "${local.bastion_standalone.common_settings.tags}"
}

module "bastion_standalone_virtual_machine" {
    source                   = "./modules/virtual_machine_by_azure_image"

    vm_count                 = "${var.ashely_bastion_standalone_count}"
    name                     = "${local.bastion_standalone.common_settings.tags.role}"
    vm_size                  = "${var.ashely_bastion_standalone_vm_size}"
    os_disk_name             = "${local.bastion_standalone.vm_settings.os_disk_name}"
    os_disk_size_gb          = "${local.bastion_standalone.vm_settings.os_disk_size_gb}"
    os_profile_username      = "${var.ashely_vm_admin_user}"

    publisher                = "${local.bastion_standalone.vm_settings.publisher}"
    offer                    = "${local.bastion_standalone.vm_settings.offer}"
    sku                      = "${local.bastion_standalone.vm_settings.sku}"

    resource_group_name   = "${module.resource_group.name}"
    location              = "${module.resource_group.location}"
    network_interface_ids = "${module.bastion_standalone_network_interface.network_interface_ids}"
    ssh_keys_key_data     = file("${path.module}/certs/bastion_standalone.pub")
    settings              = "${local.bastion_standalone.vm_settings.vm_settings}"
    tags                  = "${local.bastion_standalone.common_settings.tags}"
}