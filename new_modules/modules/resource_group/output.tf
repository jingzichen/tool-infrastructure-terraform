output "name" {
  description = "Specifies the name of the Resource Group."
  value       = azurerm_resource_group.resource_group.name
}

output "location" {
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  value       = azurerm_resource_group.resource_group.location
}