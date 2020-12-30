output "module_id" {
    value   = "${azurerm_automation_module.module.*.id}"
}