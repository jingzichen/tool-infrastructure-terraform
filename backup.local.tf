locals  {
    backup = {
        common_settings = {
            tags = "${
                merge(
                    local.common_standalone_tags,
                    map("role", "ashely")
                )
            }"
        }
        cassandra_vault = {
            name = "ashely-vault"
            sku  = "Standard"
        }
        cassandra_backup_policy = {
            name                = "ashely-vault-policy"
            time                = "16:00"
            keep_count          = 7
        }
    }
}
