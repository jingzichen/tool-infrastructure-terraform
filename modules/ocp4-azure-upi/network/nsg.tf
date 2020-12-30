resource "azurerm_network_security_group" "master" {
    name                = join("-", [var.cluster_name, "master-nsg"])
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "master" {
    subnet_id                 = azurerm_subnet.master_subnet.id
    network_security_group_id = azurerm_network_security_group.master.id
}

resource "azurerm_network_security_rule" "master_apiserver_in" {
    name                        = "apiserver_in"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.master.name
}

resource "azurerm_network_security_rule" "master_sint_in" {
    name                        = "sint_in"
    priority                    = 102
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22623"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.master.name
}

resource "azurerm_network_security_group" "infra" {
    name                = join("-", [var.cluster_name, "infra-nsg"])
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "infra" {
    subnet_id                 = azurerm_subnet.infra_subnet.id
    network_security_group_id = azurerm_network_security_group.infra.id
}

resource "azurerm_network_security_rule" "infra_apiserver_in" {
    name                        = "apiserver_in"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.infra.name
}

resource "azurerm_network_security_rule" "infra_http" {
    name                        = "tcp-80"
    priority                    = 500
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.infra.name
}

resource "azurerm_network_security_rule" "infra_https" {
    name                        = "tcp-443"
    priority                    = 501
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.infra.name
}

resource "azurerm_network_security_rule" "infra_mqtts" {
    name                        = "mqtts-31883"
    priority                    = 502
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "31883"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.infra.name
}

resource "azurerm_network_security_group" "route" {
    name                = join("-",[var.cluster_name,"route-nsg"])
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "route" {
    subnet_id                 = azurerm_subnet.route_subnet.id
    network_security_group_id = azurerm_network_security_group.route.id
}

resource "azurerm_network_security_rule" "route_apiserver_in" {
    name                        = "apiserver_in"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.route.name
}

resource "azurerm_network_security_rule" "route_http" {
    name                        = "tcp-80"
    priority                    = 500
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.route.name
}

resource "azurerm_network_security_rule" "route_https" {
    name                        = "tcp-443"
    priority                    = 501
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.route.name
}

resource "azurerm_network_security_rule" "route_mqtts" {
    name                        = "mqtts-31883"
    priority                    = 502
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "31883"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.route.name
}

resource "azurerm_network_security_group" "node" {
    name                = join("-", [var.cluster_name, "node-nsg"])
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "node" {
    subnet_id                 = azurerm_subnet.node_subnet.id
    network_security_group_id = azurerm_network_security_group.node.id
}

resource "azurerm_network_security_rule" "node_apiserver_in" {
    name                        = "apiserver_in"
    priority                    = 101
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "6443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.node.name
}

resource "azurerm_network_security_rule" "node_http" {
    name                        = "tcp-80"
    priority                    = 500
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "80"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.node.name
}

resource "azurerm_network_security_rule" "node_https" {
    name                        = "tcp-443"
    priority                    = 501
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.node.name
}
resource "azurerm_network_security_rule" "node_mqtts" {
    name                        = "mqtts-31883"
    priority                    = 502
    access                      = "Allow"
    direction                   = "Inbound"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "31883"
    source_address_prefix       = "*"
    destination_address_prefix  = "VirtualNetwork"
    resource_group_name         = var.resource_group_name
    network_security_group_name = azurerm_network_security_group.node.name
}
