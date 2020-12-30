module "tfstate_storage_account" {
    source                   = "./modules/storage_account"

    resource_group_name      = "${module.resource_group.name}"
    location                 = "${module.resource_group.location}"
    account_name             = "${local.tfstate.storage_account.account_name}"
    account_tier             = "${local.tfstate.storage_account.tier}"
    account_replication_type = "${local.tfstate.storage_account.replication_type}"
    tags                     = "${local.tfstate.common_settings.tags}"
}

module "tfstate_storage_container" {
    source                 = "./modules/storage_container"

    storage_container_name = "${local.tfstate.storage_container.container_name}"
    storage_account_name   = "${module.tfstate_storage_account.name}"
    container_access_type  = "${local.tfstate.storage_container.container_access_type}"
}