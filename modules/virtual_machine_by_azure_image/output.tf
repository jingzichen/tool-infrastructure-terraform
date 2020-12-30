output "id" {
    value = "${azurerm_virtual_machine.virtual_machine.*.id}"
}

output "tags" {
    value = "${azurerm_virtual_machine.virtual_machine.*.tags}"
}
