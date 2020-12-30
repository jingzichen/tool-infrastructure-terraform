data "azurerm_resource_group" "resource_group" {
    name = "${var.disk_resource_group_name}"
}

data "azurerm_managed_disk" "disks" {
    count               = "${length(var.managed_disk_names)}"
    name                = "${var.managed_disk_names[count.index]}"
    resource_group_name = "${var.disk_resource_group_name}"
}

resource "azurerm_snapshot" "snapshots" {
    count               = "${length(var.managed_disk_names)}"
    name                = "${var.managed_disk_names[count.index]}-snapshot-${replace(var.version_name, ".", "-")}"
    location            = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    create_option       = "Copy"
    source_uri          = "${element(data.azurerm_managed_disk.disks.*.id ,count.index)}"
    
    tags                = "${var.tags}"
}