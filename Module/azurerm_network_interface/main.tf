resource "azurerm_network_interface" "ddnic" {
  name                = "ddnic"
  location            = "Canada Central"
  resource_group_name = "ddrg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.ddsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.ddpip.id

  }
}
