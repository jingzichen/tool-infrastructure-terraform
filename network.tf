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

module "develop_vnet" {
    source                    = "./modules/virtual_network"

    resource_group_name       = "${module.resource_group.name}"
    location                  = "${var.location}"
    vnet_name                 = "${local.network.develop_vnet.name}"
    address_space             = "${local.network.develop_vnet.address_space}"
    subnet_names              = "${local.network.develop_vnet.subnet_names}"
    subnet_prefixes           = "${local.network.develop_vnet.subnet_prefixes}"
    tags                      = "${local.network.common_settings.tags}"
}


resource "azurerm_virtual_network_peering" "network_peering_develop_to_core" {
    resource_group_name          = "${module.resource_group.name}"
    name                         = "${local.network.develop_to_core_peering.name}"
    virtual_network_name         = "${module.develop_vnet.vnet_name}"
    remote_virtual_network_id    = "${module.core_vnet.vnet_id}"
    allow_virtual_network_access = "${local.network.develop_to_core_peering.allow_virtual_network_access}"
}

resource "azurerm_virtual_network_peering" "network_peering_core_to_develop" {
    resource_group_name          = "${module.resource_group.name}"
    name                         = "${local.network.core_to_develop_peering.name}"
    virtual_network_name         = "${module.core_vnet.vnet_name}"
    remote_virtual_network_id    = "${module.develop_vnet.vnet_id}"
    allow_virtual_network_access = "${local.network.core_to_develop_peering.allow_virtual_network_access}"
    depends_on                   = ["azurerm_virtual_network_peering.network_peering_develop_to_core"]
}
