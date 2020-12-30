resource "azurerm_storage_account" "storage_account" {
    resource_group_name      = "${var.resource_group_name}"
    location                 = "${var.location}"
    name                     = "${lower(var.account_name)}${lower(replace(substr(uuid(), 0, 10), "-", ""))}"
    account_tier             = "${var.account_tier}"
    account_replication_type = "${var.account_replication_type}"

    lifecycle {
        ignore_changes = ["name"]
    }

    tags                     = "${var.tags}"
}