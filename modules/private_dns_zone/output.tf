output "private_dns_id" {
    value = "${azurerm_private_dns_zone.private_dns_zone.id}"
    description = "The Prviate DNS Zone ID."
}