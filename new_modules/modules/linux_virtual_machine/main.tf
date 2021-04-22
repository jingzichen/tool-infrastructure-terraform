resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  count                 = var.vm_count
  name                  = "${var.name}-${count.index + 1}"
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  computer_name         = "${var.name}-${count.index + 1}"
  network_interface_ids = [element(var.network_interface_ids, count.index)]
  availability_set_id   = length(var.availability_set_id) > 0 ? var.availability_set_id : null

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    name                 = "${var.name}${count.index + 1}-${var.os_disk_name}"
    caching              = var.caching
    storage_account_type = var.storage_account_type
    disk_size_gb         = var.disk_size_gb
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.image_version
  }

  tags = var.tags
}