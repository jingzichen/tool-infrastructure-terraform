### Internal LB
output "internal_lb_ip" {
    value = "${azurerm_lb.internal.private_ip_address}"
}
output "internal_lb_backend_pool_id" {
    value = "${azurerm_lb_backend_address_pool.internal_lb_controlplane_pool.id}"
}


### Public LB
output "cluster_public_ip" {
    value = "${azurerm_public_ip.cluster_public_ip.ip_address}"
}

output "master_public_lb_pool_id" {
    value = "${azurerm_lb_backend_address_pool.master_public_lb_pool.id}"
}

output "cluster_lb_id" {
    value = "${azurerm_lb.cluster.id}"
}


### Subnet
output "master_subnet_id" {
    value = "${azurerm_subnet.master_subnet.id}"
}

output "master_subnet_cidr" {
    value = "${azurerm_subnet.master_subnet.address_prefix}"
}

output "infra_subnet_id" {
    value = "${azurerm_subnet.infra_subnet.id}"
}

output "infra_subnet_cidr" {
    value = "${azurerm_subnet.infra_subnet.address_prefix}"
}

output "route_subnet_id" {
    value = "${azurerm_subnet.route_subnet.id}"
}

output "route_subnet_cidr" {
    value = "${azurerm_subnet.route_subnet.address_prefix}"
}

output "node_subnet_id" {
    value = "${azurerm_subnet.node_subnet.id}"
}

output "node_subnet_cidr" {
    value = "${azurerm_subnet.node_subnet.address_prefix}"
}


### Network Security Rroup
output "master_nsg_name" {
    value = "${azurerm_network_security_group.master.name}"
}

output "master_nsg_id" {
    value = "${azurerm_network_security_group.master.id}"
}

output "infra_nsg_name" {
    value = "${azurerm_network_security_group.infra.name}"
}

output "infra_nsg_id" {
    value = "${azurerm_network_security_group.infra.id}"
}

output "route_nsg_name" {
    value = "${azurerm_network_security_group.route.name}"
}

output "route_nsg_id" {
    value = "${azurerm_network_security_group.route.id}"
}
output "node_nsg_name" {
    value = "${azurerm_network_security_group.node.name}"
}

output "node_nsg_id" {
    value = "${azurerm_network_security_group.node.id}"
}
