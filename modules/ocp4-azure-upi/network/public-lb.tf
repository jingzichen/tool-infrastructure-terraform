resource "azurerm_public_ip" "cluster_public_ip" {
    sku                 = "Standard"
    location            = "${var.location}"
    name                = "${var.cluster_name}-cluster-pip"
    resource_group_name = "${var.resource_group_name}"
    allocation_method   = "Static"
}

#data "azurerm_public_ip" "cluster_public_ip" {
#    name                = "${azurerm_public_ip.cluster_public_ip.name}"
#    resource_group_name = "${var.resource_group_name}"
#}

resource "azurerm_lb" "cluster" {
  sku                 = "Standard"
  name                = "${var.cluster_name}-cluster-lb"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"

  frontend_ip_configuration {
      name                 = "cluster-lb-ip"
      public_ip_address_id = "${azurerm_public_ip.cluster_public_ip.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "master_public_lb_pool" {
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.cluster.id}"
    name                = "${var.cluster_name}-master-public-lb-pool"
}

resource "azurerm_lb_probe" "public_lb_probe_api_internal" {
    name                = "api-internal-probe"
    resource_group_name = "${var.resource_group_name}"
    interval_in_seconds = 10
    number_of_probes    = 3
    loadbalancer_id     = "${azurerm_lb.cluster.id}"
    port                = 6443
    protocol            = "TCP"
}

resource "azurerm_lb_probe" "public_lb_sint" {
    name                = "sint-probe"
    resource_group_name = "${var.resource_group_name}"
    interval_in_seconds = 10
    number_of_probes    = 3
    loadbalancer_id     = "${azurerm_lb.cluster.id}"
    port                = 22623
    protocol            = "TCP"
}

resource "azurerm_lb_rule" "public_lb_rule_api_internal" {
    name                           = "api-internal"
    resource_group_name            = "${var.resource_group_name}"
    protocol                       = "Tcp"
    backend_address_pool_id        = "${azurerm_lb_backend_address_pool.master_public_lb_pool.id}"
    loadbalancer_id                = "${azurerm_lb.cluster.id}"
    frontend_port                  = 6443
    backend_port                   = 6443
    frontend_ip_configuration_name = "cluster-lb-ip"
    enable_floating_ip             = false
    idle_timeout_in_minutes        = 30
    load_distribution              = "Default"
    disable_outbound_snat          = false
    probe_id                       = "${azurerm_lb_probe.public_lb_probe_api_internal.id}"
}

resource "azurerm_lb_rule" "public_lb_rule_sint_internal" {
    name                           = "sint-internal"
    resource_group_name            = "${var.resource_group_name}"
    protocol                       = "Tcp"
    backend_address_pool_id        = "${azurerm_lb_backend_address_pool.master_public_lb_pool.id}"
    loadbalancer_id                = "${azurerm_lb.cluster.id}"
    frontend_port                  = 22623
    backend_port                   = 22623
    frontend_ip_configuration_name = "cluster-lb-ip"
    enable_floating_ip             = false
    idle_timeout_in_minutes        = 30
    load_distribution              = "Default"
    disable_outbound_snat          = false
    probe_id                       = "${azurerm_lb_probe.public_lb_sint.id}"
}

# resource "azurerm_lb_outbound_rule" "allow_outbound" {
#     name                    = "allow_outbound"
#     resource_group_name     = "${var.resource_group_name}"
#     loadbalancer_id         = "${azurerm_lb.cluster.id}"
#     protocol                = "Udp"
#     backend_address_pool_id = "${azurerm_lb_backend_address_pool.master_public_lb_pool.id}"
# 
#     frontend_ip_configuration {
#         name = "cluster-lb-ip"
#     }
# 
# }

