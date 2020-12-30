resource "azurerm_private_dns_a_record" "api_internal" {
    name                = "api"
    zone_name           = "${var.dns_zone_name}"
    resource_group_name = "${var.resource_group_name}"
    ttl                 = 60
    records             = ["${var.internal_lb_ip}"]
}

resource "azurerm_private_dns_a_record" "apint_internal" {
    name                = "api-int"
    zone_name           = "${var.dns_zone_name}"
    resource_group_name = "${var.resource_group_name}"
    ttl                 = 60
    records             = ["${var.internal_lb_ip}"]
}

resource "azurerm_private_dns_a_record" "etcd_a_nodes" {
    count               = "${var.etcd_count}"
    name                = "etcd-${count.index}"
    zone_name           = "${var.dns_zone_name}"
    resource_group_name = "${var.resource_group_name}"
    ttl                 = 60
    records             = ["${var.etcd_ip_addresses[count.index]}"]
}

resource "azurerm_private_dns_srv_record" "etcd_cluster" {
    name                = "_etcd-server-ssl._tcp"
    zone_name           = "${var.dns_zone_name}"
    resource_group_name = "${var.resource_group_name}"
    ttl                 = 60

    dynamic "record" {
        for_each = "${azurerm_private_dns_a_record.etcd_a_nodes.*.name}"
        iterator = name
        content {
            target   = "${name.value}.${var.dns_zone_name}"
            priority = 0
            weight   = 10
            port     = 2380
        }
    }
}
