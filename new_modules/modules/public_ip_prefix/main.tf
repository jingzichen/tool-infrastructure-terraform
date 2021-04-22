resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  name                = "${var.caller_name}-public-ip-prefix"
  location            = var.location
  resource_group_name = var.resource_group_name
  zones               = length(var.zones) > 0 ? var.zones : null
  prefix_length       = var.prefix_length

  tags = var.tags
}