resource "azurerm_storage_account" "storage_account" {
  name                      = format("%s%s", lower(var.account_name), lower(replace(substr(uuid(), 0, 10), "-", "")))
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  account_kind              = var.account_kind

  lifecycle {
    ignore_changes = [name]
  }

  tags = var.tags
}


/* Storage Container Creation */
resource "azurerm_storage_container" "container" {
  count                 = length(var.containers_list)
  name                  = var.containers_list[count.index].name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.containers_list[count.index].access_type
}


/* Storage Sharefile Creation */
resource "azurerm_storage_share" "sharefile" {
  count                = length(var.sharefile_list)
  name                 = var.sharefile_list[count.index].name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.sharefile_list[count.index].quota
}