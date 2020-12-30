data "azurerm_automation_account" "automation_account" {
    name                = "${var.automation_account_name}"
    resource_group_name = "${var.automation_account_rg}"
}

resource "azurerm_automation_runbook" "runbook" {
    name                = "${var.runbook_name}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    account_name        = "${data.azurerm_automation_account.automation_account.name}"
    log_verbose         = "${var.log_verbose}"
    log_progress        = "${var.log_progress}"
    description         = "${var.description}"
    runbook_type        = "${var.runbook_type}"

    publish_content_link {
        uri             = "${var.uri}"
    }
    
    content             = "${var.content}"
    tags                = "${var.tags}"
}