output "id" {
    value = "${azurerm_redis_cache.redis_cache.id}"
}

output "hostname" {
    value = "${azurerm_redis_cache.redis_cache.hostname}"
}

output "ssl_port" {
    value = "${azurerm_redis_cache.redis_cache.ssl_port}"
}

output "primary_access_key" {
    value = "${azurerm_redis_cache.redis_cache.primary_access_key}"
}

output "secondary_access_key" {
    value = "${azurerm_redis_cache.redis_cache.secondary_access_key}"
}

output "maxclients" {
    value = "${azurerm_redis_cache.redis_cache.redis_configuration[0].maxclients}"
}
