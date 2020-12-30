resource "azurerm_redis_cache" "redis_cache" {
    name                      = "${lower(var.name)}-${lower(replace(substr(uuid(), 0, 10), "-", ""))}"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"
    capacity                  = "${var.capacity}"
    family                    = "${var.family}"
    sku_name                  = "${var.sku_name}"

    enable_non_ssl_port       = "${var.enable_non_ssl_port}"
    private_static_ip_address = "${var.private_static_ip_address}"
    shard_count               = "${var.shard_count}"
    subnet_id                 = "${var.subnet_id}"
    tags                      = "${var.tags}" 

    redis_configuration {
        enable_authentication = "${var.enable_authentication}"
    }

    lifecycle {
        ignore_changes = ["name"]
    }
}



