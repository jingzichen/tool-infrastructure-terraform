resource "azurerm_user_assigned_identity" "main" {
    name                = "identity${var.cluster_nr}"
    resource_group_name = "${var.resource_group_name}"
    location            = "${var.location}"
}

resource "azurerm_role_assignment" "main" {
    scope                = "${var.resource_group_id}"
    role_definition_name = "Contributor"
    principal_id         = "${azurerm_user_assigned_identity.main.principal_id}"
}
