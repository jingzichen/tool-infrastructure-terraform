resource "azurerm_automation_account" "automation_account" {
    count               = "${var.automation_account_count}"
    name                = "${var.automation_account_name}-${count.index + 1}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    sku_name            = "${var.sku_name}"
    tags                = "${var.tags}"
}