resource "azurerm_subnet" "master_subnet" {
    resource_group_name  = "${var.resource_group_name}"
    address_prefix       = "${element(var.subnet_cidrs, index(var.subnet_names, "master"))}"
    virtual_network_name = "${var.vnet_name}"
    name                 = "${var.cluster_name}-master-subnet"

    lifecycle {
        ignore_changes = [ "network_security_group_id" ]
    }
}

resource "azurerm_subnet" "infra_subnet" {
    resource_group_name  = "${var.resource_group_name}"
    address_prefix       = "${element(var.subnet_cidrs, index(var.subnet_names, "infra"))}"
    virtual_network_name = "${var.vnet_name}"
    name                 = "${var.cluster_name}-infra-subnet"
    
    lifecycle {
        ignore_changes = [ "network_security_group_id" ]
    }
}

resource "azurerm_subnet" "route_subnet" {
    resource_group_name  = "${var.resource_group_name}"
    address_prefix       = "${element(var.subnet_cidrs, index(var.subnet_names, "route"))}"
    virtual_network_name = "${var.vnet_name}"
    name                 = "${var.cluster_name}-route-subnet"

    lifecycle {
        ignore_changes = [ "network_security_group_id" ]
    }
}

resource "azurerm_subnet" "node_subnet" {
    resource_group_name  = "${var.resource_group_name}"
    address_prefix       = "${element(var.subnet_cidrs, index(var.subnet_names, "node"))}"
    virtual_network_name = "${var.vnet_name}"
    name                 = "${var.cluster_name}-node-subnet"

    lifecycle {
        ignore_changes = [ "network_security_group_id" ]
    }
}
