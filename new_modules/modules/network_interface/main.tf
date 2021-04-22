resource "azurerm_network_interface" "network_interface" {
  count = var.instance_num

  location                  = var.location
  name                      = "${var.caller_name}-network-interface-${count.index + 1}"
  resource_group_name       = var.resource_group_name

  ip_configuration {
    name                          = "${var.caller_name}-ipconfig-${count.index + 1}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address            = length(var.private_ip_address) > 0 ? element(var.private_ip_address, count.index) : null
    public_ip_address_id          = length(var.public_ip_address_id) > 0 ? element(var.public_ip_address_id, count.index) : null
  }

  tags = var.tags
}