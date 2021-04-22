output "network_interface_ids" {
  description = "Ids of the vm nics provisoned."
  value       = azurerm_network_interface.network_interface.*.id
}

output "network_interface_private_ip" {
  description = "Private ip addresses of the vm nics"
  value       = azurerm_network_interface.network_interface.*.private_ip_address
}