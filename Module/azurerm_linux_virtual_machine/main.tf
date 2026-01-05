resource "azurerm_linux_virtual_machine" "ddvm" {
  name                = "ddvm"
  resource_group_name = "ddrg"
  location            = "Canada Central"
  size                = "Standard_D2s_v3"
  admin_username      = data.azurerm_key_vault_secret.kv_username.value

  network_interface_ids = [
    data.azurerm_network_interface.ddnic.id
  ]

  admin_password                  = data.azurerm_key_vault_secret.kv_password.value
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-LTS"
    version   = "latest"
  }
}
