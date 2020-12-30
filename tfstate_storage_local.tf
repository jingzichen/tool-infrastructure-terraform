locals {
    tfstate = {
        common_settings = {
          tags = "${
            merge(
              map("environment", "production"),
              map("role", "tfstate")
            )
          }"
        }

        storage_account = {
          account_name     = "tfstate"
          tier             = "Standard"
          replication_type = "LRS"
        }

        storage_container = {
          container_name    = "tfstate-storage"
          container_access_type  = "private"
        }
    }
}