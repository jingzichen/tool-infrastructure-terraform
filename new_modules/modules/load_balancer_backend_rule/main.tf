# load balancer
# [Note] You need to create a Loadbalancer, before using it.
data "azurerm_lb" "lb" {
  name                = var.lb_name
  resource_group_name = var.resource_group_name
}

# Configure backend pool of load balancer
resource "azurerm_lb_backend_address_pool" "lb_backend_address_pool" {
  name                = "${var.address_pool_name}-address-pool"
  loadbalancer_id     = data.azurerm_lb.lb.id
}

# Configure the health check for load balance rule
resource "azurerm_lb_probe" "lb_probe" {
  count = length(var.backend_rule)

  name                = "${var.backend_rule[count.index].frontend_port}-${var.backend_rule[count.index].backend_port}-up"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = data.azurerm_lb.lb.id
  protocol            = var.backend_rule[count.index].probe.protocol
  request_path        = lookup(var.backend_rule[count.index].probe, "request_path", null)
  port                = var.backend_rule[count.index].probe.port
}

# Configure the load balance rules
# Note, each rule should with a health check
resource "azurerm_lb_rule" "lb_rule" {
  count = length(var.backend_rule)

  name                    = var.backend_rule[count.index].name
  resource_group_name     = var.resource_group_name
  loadbalancer_id         = data.azurerm_lb.lb.id
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_address_pool.id

  probe_id                       = element(azurerm_lb_probe.lb_probe.*.id, count.index)
  protocol                       = var.backend_rule[count.index].protocol
  frontend_port                  = var.backend_rule[count.index].frontend_port
  backend_port                   = var.backend_rule[count.index].backend_port
  idle_timeout_in_minutes        = var.backend_rule[count.index].idle_timeout_in_minutes
  frontend_ip_configuration_name = var.frontend_ip_config_name

  depends_on = [azurerm_lb_probe.lb_probe]
}