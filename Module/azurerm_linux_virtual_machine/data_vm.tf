data "azurerm_key_vault" "kv" {
  name                = "dhruv-vault2"
  resource_group_name = "dhruv-bd"
}

data "azurerm_key_vault_secret" "kv_username" {
  name         = "username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "kv_password" {
  name         = "password1"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_network_interface" "ddnic" {
  name                = "cdnic"
  resource_group_name = "cdrg"
}

data "azurerm_subnet" "ddsubnet" {
  name                 = "cdsubnet"
  virtual_network_name = "cdvnet"
  resource_group_name  = "cdrg"
}
