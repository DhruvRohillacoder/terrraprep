data "azurerm_subnet" "ddsubnet" {
  name                 = "ddsubnet"
  virtual_network_name = "ddvnet"
  resource_group_name  = "ddrg"
}

data "azurerm_public_ip" "ddpip" {
  name                = "ddpip"
  resource_group_name = "ddrg"
}
