output "account_id" {
    value   = "${azurerm_automation_account.automation_account.*.id}"
}