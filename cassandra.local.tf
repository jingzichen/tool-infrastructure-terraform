locals {
    cassandra = {
        common_settings = {
            tags = "${
                merge(
                    local.common_standalone_tags,
                    map("role", "ashely")
                )
            }"
        }

        as_settings  = {}

        nsg_settings = {
            custom_rules = [{
                name                        = "ashelycassandra_7000"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "TCP"
                source_port_range           = "*"
                destination_port_range      = 7000
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
            },
            {
                name                        = "ashelycassandra-6121"
                priority                    = 200
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "TCP"
                source_port_range           = "*"
                destination_port_range      = 6121
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
            }]

        }

        nic_settings = {
            private_ip_address = ["10.116.2.4", "10.116.2.5", "10.116.2.6"]
            private_ip_address_allocation = "Static"
        }

        vm_settings  = {
            publisher               = "OpenLogic"
            offer                   = "CentOS"
            sku                     = "7.7"
            os_disk_name            = "os-disk"
            os_disk_size_gb         = "30"
            vm_settings             = [
                {
                    data_disk_create_option = "Empty"
                    data_disk_size_gb       = "30"
                    managed_disk_type       = "Standard_LRS"
                },
                {
                    data_disk_create_option = "Empty"
                    data_disk_size_gb       = "30"
                    managed_disk_type       = "StandardSSD_LRS"
                }
            ]
        }

        # Variables for cassandra_lb
        lb_settings = {
            caller_name = "ashelycassandra"
            type = "private"
            sku = "Standard"
            private_ip_address = "10.116.2.7"
            private_ip_address_allocation = "Static"

            name = "ashelycassandra-load-balancer"
            backend_address_pool_name = "ashelycassandra-address-pool"
            backend_rule =  [{
                name                    = "ashelycassandra-lb-rule-7000-7000"
                protocol                = "Tcp"
                frontend_port           = 7000
                backend_port            = 7000
                idle_timeout_in_minutes = 10
                probe = {
                    protocol     = "Tcp"
                    port         = 7000
                }
            }, {
                name                    = "ashelycassandra-lb-rule-9042-9042"
                protocol                = "Tcp"
                frontend_port           = 9042
                backend_port            = 9042
                idle_timeout_in_minutes = 10
                probe = {
                    protocol     = "Tcp"
                    port         = 9042
                }
            }]
        }
    }
}