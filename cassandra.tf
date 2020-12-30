module "cassandra_availability_set" {
    source              = "./modules/availability_set"

    name                = "ashely"
    resource_group_name = "${module.resource_group.name}"
    location            = "${module.resource_group.location}"
    tags                = "${local.cassandra.common_settings.tags}"
}

module "cassandra_network_security_group" {
    source              = "./modules/network_security_group"

    resource_group_name = "${module.resource_group.name}"
    location            = "${module.resource_group.location}"
    security_group_name = "ashely"
    custom_rules        = "${local.cassandra.nsg_settings.custom_rules}"
    tags                = "${local.cassandra.common_settings.tags}"
}

# Create a private load balancer
module "cassandra_lb" {
    source = "./modules/load_balancer"

    # Basic Information
    caller_name          = "${local.cassandra.common_settings.tags.role}"
    type                 = "${local.cassandra.lb_settings.type}"
    location             = "${module.resource_group.location}"
    resource_group_name  = "${module.resource_group.name}"

    sku                  = "${local.cassandra.lb_settings.sku}"
    subnet_id            = "${data.azurerm_subnet.core_subnet[index(module.core_vnet.subnet_names, "ashelynode")].id}"
    private_ip_address   = "${local.cassandra.lb_settings.private_ip_address}"
    private_ip_address_allocation = "${local.cassandra.lb_settings.private_ip_address_allocation}"

    # Backend Pool Settings
    backend_rule              = "${local.cassandra.lb_settings.backend_rule}"

    tags = "${local.cassandra.common_settings.tags}"
}

# Create network interface for Cassandra VMs
module "cassandra_network_interface" {
    source                    = "./modules/network_interface"

    instance_num              = "${var.ashely_cassandra_count}"
    caller_name               = "${local.cassandra.common_settings.tags.role}"
    location                  = "${module.resource_group.location}"
    resource_group_name       = "${module.resource_group.name}"
    network_security_group_id = "${module.cassandra_network_security_group.network_security_group_id}"
    subnet_id                 = "${data.azurerm_subnet.core_subnet[index(module.core_vnet.subnet_names, "ashelynode")].id}"
    private_ip_address_allocation = "${local.cassandra.nic_settings.private_ip_address_allocation}"
    private_ip_address        = "${local.cassandra.nic_settings.private_ip_address}"

    backend_address_pool_id = {
        "id" = "${module.cassandra_lb.lb_backend_address_pool_id}"
    }

    tags                      = "${local.cassandra.common_settings.tags}"
}

module "cassandra_virtual_machine" {
    source                   = "./modules/virtual_machine_by_azure_image"

    vm_count                 = "${var.ashely_cassandra_count}"
    name                     = "${local.cassandra.common_settings.tags.role}"
    vm_size                  = "${var.ashely_cassandra_vm_size}"
    os_disk_name             = "${local.cassandra.vm_settings.os_disk_name}"
    os_disk_size_gb          = "${local.cassandra.vm_settings.os_disk_size_gb}"
    os_profile_username      = "${var.ashely_vm_admin_user}"

    publisher                = "${local.cassandra.vm_settings.publisher}"
    offer                    = "${local.cassandra.vm_settings.offer}"
    sku                      = "${local.cassandra.vm_settings.sku}"

    resource_group_name      = "${module.resource_group.name}"
    location                 = "${module.resource_group.location}"
    availability_set_id      = "${module.cassandra_availability_set.id}"
    network_interface_ids    = "${module.cassandra_network_interface.network_interface_ids}"
    ssh_keys_key_data        = file("${path.module}/certs/cassandra.pub")
    settings                 = "${local.cassandra.vm_settings.vm_settings}"
    tags                     = "${local.cassandra.common_settings.tags}"
}