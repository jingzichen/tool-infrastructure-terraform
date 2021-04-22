output "lb_backend_address_pool_id" {
  description = "Export backend address pool id"
  value       = azurerm_lb_backend_address_pool.lb_backend_address_pool.id
}