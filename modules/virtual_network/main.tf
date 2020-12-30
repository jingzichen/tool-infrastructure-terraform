resource "azurerm_virtual_network" "vnet" {
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
    name                = "${var.vnet_name}"
    address_space       = ["${var.address_space}"]
    tags                = "${var.tags}"
}

resource "azurerm_subnet" "subnet" {
    count                     = "${length(var.subnet_names)}"
    resource_group_name       = "${var.resource_group_name}"
    name                      = "${var.subnet_names[count.index]}"
    address_prefix            = "${var.subnet_prefixes[count.index]}"
    virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
}
