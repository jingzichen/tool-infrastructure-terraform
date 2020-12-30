/* Azure information */
subscription_id             = "<subscription_id>"
client_id                   = "<client_id>"
client_certificate_password = "<client_certificate_password>"
tenant_id                   = "<tenant_id>"
client_certificate_path     = "./certs/service-principal.pfx"

/* Cluster information */
location            = "southeastasia"
resource_group_name = "ashely-rg"
ashely_vm_admin_user = "ashely"

# Standalone resources
ashely_cassandra_count             = "3"
ashely_bastion_standalone_count    = "1"

/* VM Spec */
ashely_bastion_standalone_vm_size = "Standard_B2s"
ashely_cassandra_vm_size          = "Standard_B2s"