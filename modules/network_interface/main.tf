# Manages a Network Interface located in a Virtual Network, usually attached to a Virtual Machine.
resource "azurerm_network_interface" "network_interface" {
    count = "${var.instance_num}"
    name = "${var.caller_name}_network_interface_${count.index + 1}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    network_security_group_id = "${var.network_security_group_id}"

    ip_configuration {
        name = "${var.caller_name}_ipconfig_${count.index + 1}"
        subnet_id = "${var.subnet_id}"
        private_ip_address_allocation = "${var.private_ip_address_allocation}"
        private_ip_address  = "${length(var.private_ip_address) > 0 ? element(var.private_ip_address, count.index) : null}"
        public_ip_address_id = "${length(var.public_ip_address_id) > 0 ? element(var.public_ip_address_id, count.index) : null}"
    }

    tags = "${var.tags}"
}

# Manages the association between a Network Interface and a Load Balancer's Backend Address Pool.
resource "azurerm_network_interface_backend_address_pool_association" "network_interface_backend_address_pool_association" {
    count = "${length(keys(var.backend_address_pool_id)) > 0 ? var.instance_num : "0"}"
    network_interface_id = "${element(azurerm_network_interface.network_interface.*.id, count.index)}"
    ip_configuration_name = "${var.caller_name}_ipconfig_${count.index + 1}"
    backend_address_pool_id = "${var.backend_address_pool_id.id}"
}
