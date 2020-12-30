resource "azurerm_public_ip" "public_ip" {
    count               = "${var.public_ip_num}"
    name                = "${var.caller_name}-public-ip-${count.index + 1}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    allocation_method   = "${var.allocation_method}"
    sku                 = "${var.sku}"
    domain_name_label   = "${element(var.public_ip_dns, count.index)}"

    tags = "${var.tags}"
}
