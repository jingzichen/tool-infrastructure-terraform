#The Vnet of Lafite
data "azurerm_virtual_network" "source" {
    name                = var.target_peering_vnet
    resource_group_name = var.resource_group_name
}

#The router subnet of Lafite
data "azurerm_subnet" "source_subnet" {
    name                 = local.target_lb.subnet
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.target_peering_vnet
}

#Those what do you want peering vnet
data "azurerm_virtual_network" "targets" {
    count               = length(local.association_list)
    name                = local.association_list[count.index].vnet
    resource_group_name = local.association_list[count.index].resourceGroup
}

#Those what do you whant peering vnet will peering Lafite vnet
resource "azurerm_virtual_network_peering" "target_vnets" {
    count                        = length(data.azurerm_virtual_network.targets)
    name                         = local.association_list[count.index].vnet
    resource_group_name          = var.resource_group_name
    virtual_network_name         = var.target_peering_vnet
    remote_virtual_network_id    = data.azurerm_virtual_network.targets[count.index].id
    allow_virtual_network_access = true
}

#Lafite vnet will peering those what do you whant peering vnet
resource "azurerm_virtual_network_peering" "peering_source" {
    count                        = length(data.azurerm_virtual_network.targets)
    name                         = local.association_list[count.index].vnet
    resource_group_name          = local.association_list[count.index].resourceGroup
    virtual_network_name         = data.azurerm_virtual_network.targets[count.index].name
    remote_virtual_network_id    = data.azurerm_virtual_network.source.id
    allow_virtual_network_access = true
}

#Internal route VIP address
resource "azurerm_lb" "internal" {
    name                = local.target_lb.name
    location            = var.resource_group_location
    resource_group_name = var.resource_group_name
    sku                 = "Standard"
  # Front End Load Balancer
    frontend_ip_configuration {
        name                          = local.target_lb.frontend_ip.name
        subnet_id                     = data.azurerm_subnet.source_subnet.id
        private_ip_address            = local.target_lb.frontend_ip.private_ip_address
        private_ip_address_allocation = "${local.target_lb.frontend_ip.private_ip_address_allocation == "Static" ? "Static" : "Dynamic"}"
    }
}

#LB http Probe - Checks to see which VMs are healthy and available
resource "azurerm_lb_probe" "http" {
    resource_group_name = var.resource_group_name
    loadbalancer_id     = azurerm_lb.internal.id
    name                = "HTTP"
    port                = local.target_lb.http_probe_port
}

#LB https Probe - Checks to see which VMs are healthy and available
resource "azurerm_lb_probe" "https" {
    resource_group_name = var.resource_group_name
    loadbalancer_id     = azurerm_lb.internal.id
    name                = "HTTPS"
    port                = local.target_lb.https_probe_port
}

# Back End Address Pool
resource "azurerm_lb_backend_address_pool" "internal_http" {
    resource_group_name = var.resource_group_name
    loadbalancer_id     = azurerm_lb.internal.id
    name                = var.azurerm_lb_backend_address_pool_name
    depends_on          = [azurerm_lb_probe.http]
}

# Load Balancer Rule
resource "azurerm_lb_rule" "http_rule" {
    resource_group_name            = var.resource_group_name
    loadbalancer_id                = azurerm_lb.internal.id
    name                           = var.lb_http_rule_name
    protocol                       = var.lb_http_rule_protocol
    frontend_port                  = 80
    backend_port                   = var.http_probe_port
    frontend_ip_configuration_name = local.target_lb.frontend_ip.name
    backend_address_pool_id        = azurerm_lb_backend_address_pool.internal_http.id
    probe_id                       = azurerm_lb_probe.http.id
    depends_on                     = [azurerm_lb_backend_address_pool.internal_http]
}

# Load Balancer Rule
resource "azurerm_lb_rule" "https_rule" {
    resource_group_name            = var.resource_group_name
    loadbalancer_id                = azurerm_lb.internal.id
    name                           = var.lb_https_rule_name
    protocol                       = var.lb_https_rule_protocol
    frontend_port                  = 443
    backend_port                   = var.https_probe_port
    frontend_ip_configuration_name = local.target_lb.frontend_ip.name
    backend_address_pool_id        = azurerm_lb_backend_address_pool.internal_http.id
    probe_id                       = azurerm_lb_probe.https.id
    depends_on                     = [azurerm_lb_backend_address_pool.internal_http]
}

# Load Lafite DNS Object
resource "azurerm_private_dns_zone" "internal" {
    name                = local.private_dns.domain
    resource_group_name = var.resource_group_name
}

# Create a DNS A-Record using the private IP address
resource "azurerm_private_dns_a_record" "internal" {
    name                = local.private_dns.record
    zone_name           = azurerm_private_dns_zone.internal.name
    resource_group_name = var.resource_group_name
    ttl                 = local.private_dns.ttl
    records             = [local.target_lb.frontend_ip.private_ip_address]
    depends_on          = [azurerm_private_dns_zone.internal]
}

# Connect the DNS with peering vnet
resource "azurerm_private_dns_zone_virtual_network_link" "internal" {
    count                 = length(data.azurerm_virtual_network.targets)
    name                  = local.association_list[count.index].vnet
    resource_group_name   = var.resource_group_name
    private_dns_zone_name = azurerm_private_dns_zone.internal.name
    virtual_network_id    = data.azurerm_virtual_network.targets[count.index].id
}
