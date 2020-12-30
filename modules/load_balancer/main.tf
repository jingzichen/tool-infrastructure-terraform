# Create load balancer
resource "azurerm_lb" "lb" {
    name                = "${var.caller_name}-load-balancer"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    sku                 = "${var.sku}"

    frontend_ip_configuration {
        name                          = "default"
        public_ip_address_id          = "${length(var.public_ip_address_id) > 0 ? element(var.public_ip_address_id, 0) : null}"
        subnet_id                     = "${var.subnet_id == null ? null : var.subnet_id }"
        private_ip_address            = "${var.type == null ? null : var.private_ip_address}"
        private_ip_address_allocation = "${var.private_ip_address_allocation}"
        # zones                = "${var.type == "public" ? ["zone_redundant"] : []}"
    }

    tags = "${var.tags}"
}

# Configure backend pool of load balancer
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
    name                = "${var.caller_name}-address-pool"
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.lb.id}"
}

# Configure the health check for load balance rule
resource "azurerm_lb_probe" "lb_probe" {
    count = length("${var.backend_rule}")

    name                = "${var.backend_rule[count.index].frontend_port}-${var.backend_rule[count.index].backend_port}-up"
    resource_group_name = "${var.resource_group_name}"
    loadbalancer_id     = "${azurerm_lb.lb.id}"
    protocol            = "${var.backend_rule[count.index].probe.protocol}"
    request_path        = "${lookup(var.backend_rule[count.index].probe, "request_path", null)}"
    port                = "${var.backend_rule[count.index].probe.port}"
}

# Configure the load balance rules
# Note, each rule should with a health check
resource "azurerm_lb_rule" "lb_rule" {
    count = length("${var.backend_rule}")

    name                    = "${var.backend_rule[count.index].name}"
    resource_group_name     = "${var.resource_group_name}"
    loadbalancer_id         = "${azurerm_lb.lb.id}"
    backend_address_pool_id = "${azurerm_lb_backend_address_pool.lb_backend_address_pool.id}"

    probe_id      = "${element(azurerm_lb_probe.lb_probe.*.id, count.index)}"
    protocol      = "${var.backend_rule[count.index].protocol}"
    frontend_port = "${var.backend_rule[count.index].frontend_port}"
    backend_port  = "${var.backend_rule[count.index].backend_port}"
    # idle_timeout_in_minutes = "${lookup(var.backend_rule[count.index], "idle_timeout_in_minutes", 4)}"   ### [TODO] Failed to read custom idle_timeout_in_minutes ###
    idle_timeout_in_minutes = "${var.backend_rule[count.index].idle_timeout_in_minutes}"
    frontend_ip_configuration_name = "default"

    depends_on = ["azurerm_lb_probe.lb_probe"]
}
