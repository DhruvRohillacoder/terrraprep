data "azurerm_key_vault" "kv" {
  name                = "dhruv-vault2"
  resource_group_name = "dhruv-bd"
}

data "azurerm_key_vault_secret" "kv_username" {
  name         = "username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kv_password" {
  name         = "password"
  key_vault_id = data.azurerm_key_vault.kv.id
}
#####################################
# NIC ↔ NSG ASSOCIATION (ROOT LEVEL)
#####################################
resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = module.nic.nic_ids["nic1"]
  network_security_group_id = module.nsg.nsg_ids["ni"]
}
