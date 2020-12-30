# The private dns for master
resource "azurerm_private_dns_zone" "private" {
    name                = "${var.cluster_name}.${var.base_domain}"
    resource_group_name = "${var.resource_group_name}"
}


# Virtual networks that can be linked to this Private DNS zone
resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link_pdns" {
    name                  = "${var.cluster_name}.${var.base_domain}"
    resource_group_name   = "${var.resource_group_name}"
    private_dns_zone_name = "${azurerm_private_dns_zone.private.name}"
    virtual_network_id    = "${var.vnet_id}"
}
