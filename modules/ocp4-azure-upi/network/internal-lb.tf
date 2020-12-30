resource "azurerm_lb" "internal" {
    sku                 = "Standard"
    name                = "${var.cluster_name}-internal-lb"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"

    frontend_ip_configuration {
        name                          = "internal-lb-ip"
        subnet_id                     = "${azurerm_subnet.master_subnet.id}"
        private_ip_address_allocation = "Static"
        private_ip_address            = "${cidrhost(element(var.subnet_cidrs, index(var.subnet_names, "master")), -2)}"
    }
}

resource "azurerm_lb_backend_address_pool" "internal_lb_controlplane_pool" {
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.internal.id}"
    name                = "${var.cluster_name}-internal-controlplane"
}

resource "azurerm_lb_probe" "internal_lb_probe_api_internal" {
    name                = "api-internal-probe"
    resource_group_name = "${var.resource_group_name}"
    interval_in_seconds = 10
    number_of_probes    = 3
    loadbalancer_id     = "${azurerm_lb.internal.id}"
    port                = 6443
    protocol            = "tcp"
}

resource "azurerm_lb_probe" "internal_lb_probe_sint" {
    name                = "sint-probe"
    resource_group_name = "${var.resource_group_name}"
    interval_in_seconds = 10
    number_of_probes    = 3
    loadbalancer_id     = "${azurerm_lb.internal.id}"
    port                = 22623
    protocol            = "tcp"
}

resource "azurerm_lb_rule" "internal_lb_rule_api_internal" {
    name                           = "api-internal"
    resource_group_name            = "${var.resource_group_name}"
    protocol                       = "Tcp"
    backend_address_pool_id        = "${azurerm_lb_backend_address_pool.internal_lb_controlplane_pool.id}"
    loadbalancer_id                = "${azurerm_lb.internal.id}"
    frontend_port                  = 6443
    backend_port                   = 6443
    frontend_ip_configuration_name = "internal-lb-ip"
    enable_floating_ip             = false
    idle_timeout_in_minutes        = 30
    load_distribution              = "Default"
    probe_id                       = "${azurerm_lb_probe.internal_lb_probe_api_internal.id}"
}

resource "azurerm_lb_rule" "internal_lb_rule_sint" {
    name                           = "sint"
    resource_group_name            = "${var.resource_group_name}"
    protocol                       = "Tcp"
    backend_address_pool_id        = "${azurerm_lb_backend_address_pool.internal_lb_controlplane_pool.id}"
    loadbalancer_id                = "${azurerm_lb.internal.id}"
    frontend_port                  = 22623
    backend_port                   = 22623
    frontend_ip_configuration_name = "internal-lb-ip"
    enable_floating_ip             = false
    idle_timeout_in_minutes        = 30
    load_distribution              = "Default"
    probe_id                       = "${azurerm_lb_probe.internal_lb_probe_sint.id}"
}
