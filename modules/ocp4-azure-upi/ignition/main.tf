resource "azurerm_storage_blob" "ignition" {
    resource_group_name    = "${var.resource_group_name}"
    storage_account_name   = "${var.ignition_storage_account_name}"
    storage_container_name = "${var.storage_container_name}"
    name                   = "${var.name}.ign"
    source                 = "ignition_files/${var.cluster_name}/${var.name}.ign"
    type                   = "block"
}

data "azurerm_storage_account_sas" "ignition" {
    connection_string = "${var.primary_connection_string}"
    https_only        = true
    resource_types {
        service   = false
        container = false
        object    = true
    }
    services {
        blob  = true
        queue = false
        table = false
        file  = false
    }
    start  = timestamp()
    expiry = timeadd(timestamp(), "24h")
    permissions {
        read    = true
        list    = true
        create  = false
        add     = false
        delete  = false
        process = false
        write   = false
        update  = false
    }
}

data "ignition_config" "redirect" {
    replace {
        source = "${azurerm_storage_blob.ignition.url}${data.azurerm_storage_account_sas.ignition.sas}"
    }
}

