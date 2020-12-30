data "azurerm_automation_account" "automation_account" {
    name                = "${var.automation_account_name}"
    resource_group_name = "${var.automation_account_rg}"
}

resource "azurerm_automation_schedule" "schedule" {
    name                    = "${var.schedule_name}"
    resource_group_name     = "${data.azurerm_automation_account.automation_account.resource_group_name}"
    automation_account_name = "${data.azurerm_automation_account.automation_account.name}"
    frequency               = "${var.frequency}"
    interval                = "${var.interval}"
    timezone                = "${var.timezone}"
    description             = "${var.description}"
}

resource "azurerm_automation_job_schedule" "job_schedule" {
    resource_group_name     = "${data.azurerm_automation_account.automation_account.resource_group_name}"
    automation_account_name = "${data.azurerm_automation_account.automation_account.name}"
    schedule_name           = "${azurerm_automation_schedule.schedule.name}"
    runbook_name            = "${var.runbook_name}"

    depends_on = [
        "azurerm_automation_schedule.schedule"
    ]
}
