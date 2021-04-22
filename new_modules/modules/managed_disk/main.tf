resource "azurerm_managed_disk" "disk" {
  count = var.disk_count

  name                 = "${var.disk_name}-${count.index + 1}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  storage_account_type = var.storage_account_type
  create_option        = var.create_option
  disk_size_gb         = var.disk_size_gb

  tags = var.tags
}