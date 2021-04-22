output "id" {
  value = azurerm_storage_account.storage_account.id
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage_account.primary_blob_endpoint
}

output "primary_connection_string" {
  value = azurerm_storage_account.storage_account.primary_connection_string
}

output "name" {
  value = azurerm_storage_account.storage_account.name
}

output "containers" {
  description = "Map of containers."
  value       = { for c in azurerm_storage_container.container : c.name => c.id }
}

output "file_shares" {
  description = "Map of Storage SMB file shares."
  value       = { for f in azurerm_storage_share.sharefile : f.name => f.id }
}