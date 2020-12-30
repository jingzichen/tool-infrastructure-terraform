# module "external_vnet" {
#     source                    = "./modules/virtual_network"

#     resource_group_name       = "${module.resource_group.name}"
#     location                  = "${var.location}"
#     vnet_name                 = "${local.network.external_vnet.name}"
#     address_space             = "${local.network.external_vnet.address_space}"
#     subnet_names              = "${local.network.external_vnet.subnet_names}"
#     subnet_prefixes           = "${local.network.external_vnet.subnet_prefixes}"
#     tags                      = "${local.network.common_settings.tags}"
# }

module "core_vnet" {
    source                    = "./modules/virtual_network"

    resource_group_name       = "${module.resource_group.name}"
    location                  = "${var.location}"
    vnet_name                 = "${local.network.core_vnet.name}"
    address_space             = "${local.network.core_vnet.address_space}"
    subnet_names              = "${local.network.core_vnet.subnet_names}"
    subnet_prefixes           = "${local.network.core_vnet.subnet_prefixes}"
    tags                      = "${local.network.common_settings.tags}"
}

# module "develop_vnet" {
#     source                    = "./modules/virtual_network"

#     resource_group_name       = "${module.resource_group.name}"
#     location                  = "${var.location}"
#     vnet_name                 = "${local.network.develop_vnet.name}"
#     address_space             = "${local.network.develop_vnet.address_space}"
#     subnet_names              = "${local.network.develop_vnet.subnet_names}"
#     subnet_prefixes           = "${local.network.develop_vnet.subnet_prefixes}"
#     tags                      = "${local.network.common_settings.tags}"
# }
