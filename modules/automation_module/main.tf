data "azurerm_automation_account" "automation_account" {
    name                = "${var.automation_account_name}"
    resource_group_name = "${var.automation_account_rg}"
}

resource "azurerm_automation_module" "module" {
    count                   = "${length(var.module_names)}"
    name                    = "${var.module_names[count.index]}"
    resource_group_name     = "${data.azurerm_automation_account.automation_account.resource_group_name}"
    automation_account_name = "${data.azurerm_automation_account.automation_account.name}"
    module_link {
        uri                 = "${element(var.uri ,count.index)}"
    }
}