resource "azurerm_availability_set" "availability_set" {
    name                         = "${var.name}-availability-set"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group_name}"  
    platform_fault_domain_count  = "${var.platform_fault_domain_count}"
    platform_update_domain_count = "${var.platform_update_domain_count}"
    managed                      = true
    tags                         = "${var.tags}"
}

