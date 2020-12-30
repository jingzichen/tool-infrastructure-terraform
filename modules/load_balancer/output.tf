output "lb_id" {
    value = "${azurerm_lb.lb.id}"
    description = "Export backend address pool id"
}

output "lb_backend_address_pool_id" {
    value = "${azurerm_lb_backend_address_pool.lb_backend_address_pool.id}"
    description = "Export backend address pool id"
}
