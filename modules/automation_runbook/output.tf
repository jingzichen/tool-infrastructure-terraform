output "runbook_id" {
    value   = "${azurerm_automation_runbook.runbook.*.id}"
}