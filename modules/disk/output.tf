output "id" {
    value   = "${azurerm_managed_disk.disk.*.id}"
}