locals {
    bastion_standalone = {
        common_settings = {
            tags = "${
                merge(
                    local.common_standalone_tags,
                    map("role", "bastion-standalone")
                )
            }"
        }

        pip_settings = {
            public_ip_num     = "${var.ashely_bastion_standalone_count}"
            allocation_method = "Static"
        }

        nsg_settings = {
            custom_rules = [{
                name                        = "bastion-standalone-ssh"
                priority                    = 100
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "TCP"
                source_port_range           = "*"
                destination_port_range      = 22
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
            },{
                name                        = "bastion-standalone-3128"
                priority                    = 200
                direction                   = "Inbound"
                access                      = "Allow"
                protocol                    = "TCP"
                source_port_range           = "*"
                destination_port_range      = 3128
                source_address_prefix       = "*"
                destination_address_prefix  = "*"
            }]
        }

        ni_settings = {}

        vm_settings = {
            publisher               = "OpenLogic"
            offer                   = "CentOS"
            sku                     = "7.7"
            os_disk_name            = "os-disk"
            os_disk_size_gb         = "30"
            vm_settings             = []
        }
    }
}