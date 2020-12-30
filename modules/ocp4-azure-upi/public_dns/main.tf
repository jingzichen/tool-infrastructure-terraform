### Public DNS
resource "azurerm_dns_zone" "public" {
    name                = "${var.base_domain}"
    resource_group_name = "${var.resource_group_name}"
}

