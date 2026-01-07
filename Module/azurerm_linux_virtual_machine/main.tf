resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vm

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  size                = each.value.size

  network_interface_ids = var.network_interface_ids

  # 🔥 यही missing था
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    caching              = var.os_disk["vmos1"].caching
    storage_account_type = var.os_disk["vmos1"].storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference["vmsource1"].publisher
    offer     = var.source_image_reference["vmsource1"].offer
    sku       = var.source_image_reference["vmsource1"].sku
    version   = var.source_image_reference["vmsource1"].version
  }
}
