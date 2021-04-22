output "ids" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.*.id
}

output "tags" {
  value = azurerm_linux_virtual_machine.linux_virtual_machine.*.tags
}