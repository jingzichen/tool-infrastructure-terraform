resource "azurerm_public_ip" "public_ip" {
  count               = var.public_ip_num
  name                = "${var.caller_name}-public-ip-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = var.allocation_method

  sku                     = lookup(var.ip_addr, "sku", null)
  ip_version              = lookup(var.ip_addr, "ip_version", null)
  domain_name_label       = lookup(var.ip_addr, "dns_prefix", null)
  idle_timeout_in_minutes = lookup(var.ip_addr, "timeout", null)
  zones                   = lookup(var.ip_addr, "zones", null)
  reverse_fqdn            = lookup(var.ip_addr, "reverse_fqdn", null)
  public_ip_prefix_id     = lookup(var.ip_addr, "public_ip_prefix_id", null)

  tags = var.tags
}