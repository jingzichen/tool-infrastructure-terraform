resource "azurerm_public_ip" "public_ip" {
  count               = var.public_ip_count
  name                = "${var.caller_name}-nat-gw-public-ip-${count.index + 1}"
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

# Create a NAT gateway, and attach public IP addresses
resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "${var.caller_name}-nat-gw"
  location                = var.location
  resource_group_name     = var.resource_group_name
  sku_name                = var.nat_gateway_sku
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones

  tags = var.tags
}

# Manages the association between a Nat Gateway and a Public IP.
resource "azurerm_nat_gateway_public_ip_association" "public_ip_nat_association" {
  count                = length(azurerm_public_ip.public_ip.*.id)
  public_ip_address_id = element(azurerm_public_ip.public_ip.*.id, count.index)
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
}

# Configure subnets with the NAT gateway
resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  count          = length(var.associated_subnet_ids)
  subnet_id      = element(var.associated_subnet_ids, count.index)
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}