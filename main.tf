provider "azurerm" {
    version = "=1.44.0"

    subscription_id             = "${var.subscription_id}"
    client_id                   = "${var.client_id}"
    client_certificate_password = "${var.client_certificate_password}"
    tenant_id                   = "${var.tenant_id}"
    client_certificate_path     = "${var.client_certificate_path}"
}

module "resource_group" {
    source   = "./modules/resource_group"

    name     = "${var.resource_group_name}"
    location = "${var.location}"
}
/*
If you need to use container to store your tfstate,you can open this block.
 */

# terraform {
#     backend "azurerm" {
#         resource_group_name   = "prod-lafite-gen-2"
#         storage_account_name  = "<storage_account_name>"
#         container_name        = "<container_name>"
#         key                   = "terraform.tfstate"
#     }
# }

data "azurerm_subnet" "core_subnet" {
    count                = "${length(module.core_vnet.subnet_names)}"
    resource_group_name  = "${module.resource_group.name}"
    name                 = "${module.core_vnet.subnet_names[count.index]}"
    virtual_network_name = "${module.core_vnet.vnet_name}"
}

# data "azurerm_subnet" "external_subnet" {
#     count                = "${length(module.external_vnet.subnet_names)}"
#     resource_group_name  = "${module.resource_group.name}"
#     name                 = "${module.external_vnet.subnet_names[count.index]}"
#     virtual_network_name = "${module.external_vnet.vnet_name}"
# }

data "azurerm_subnet" "develop_subnet" {
    count                = "${length(module.develop_vnet.subnet_names)}"
    resource_group_name  = "${module.resource_group.name}"
    name                 = "${module.develop_vnet.subnet_names[count.index]}"
    virtual_network_name = "${module.develop_vnet.vnet_name}"
}