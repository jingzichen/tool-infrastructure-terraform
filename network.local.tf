locals  {
    network = {
        common_settings = {
            tags = "${
                merge(
                    local.common_tags,
                    map("role", "network")
                )
            }"
        }

        external_vnet = {
            name            = "ashelyexternal"
            address_space   = "10.115.0.0/17"
            subnet_names    = ["ashelyrouter"]
            subnet_prefixes = ["10.115.0.0/24"]
        }

        core_vnet = {
            name            = "ashelycore"
            address_space   = "10.116.0.0/17"
            subnet_names    = ["ashelynode"]
            subnet_prefixes = ["10.116.2.0/24"]
        }

        develop_vnet = {
            name            = "develop"
            address_space   = "10.116.128.0/17"
            subnet_names    = ["develop"]
            subnet_prefixes = ["10.116.128.0/24"]
        }
    }
}
