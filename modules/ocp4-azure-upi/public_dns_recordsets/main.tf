### Public DNS records
resource "azurerm_dns_a_record" "api_external" {
    name                = "api.${var.cluster_name}"
    zone_name           = "${var.base_domain}"
    resource_group_name = "${var.resource_group_name}"
    ttl                 = 300
    records             = ["${var.cluster_public_ip}"]
}
