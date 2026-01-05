module "rg" {
  source = "../../Module/rg"
  rg = {
    r1 = {
      name     = "cdrg"
      location = "Canada Central"
  } }
}
module "vnet" {

  source     = "../../Module/azurerm_vnet"
  depends_on = [module.rg]
  vnet = {
    v1 = {
      name                = "cdvnet"
      location            = "Canada Central"
      resource_group_name = "cdrg"
      address_space       = ["10.0.0.0/16"]
    }
  }
}
module "subnet" {

  source     = "../../Module/azurerm_subnet"
  depends_on = [module.vnet]
  subnet = {
    s1 = {
      name                 = "cdsubnet"
      resource_group_name  = "cdrg"
      virtual_network_name = "cdvnet"
      address_prefixes     = ["10.0.1.0/24"]
    }
  }
}
module "pip" {
  source     = "../../Module/azurerm_public_ip"
  depends_on = [module.rg]
  pip = {
    p1 = {
      name                = "cdpip"
      resource_group_name = "cdrg"
      location            = "Canada Central"
      allocation_method   = "Static"
      sku                 = "Standard"
    }
  }
}

module "nsg" {
  source     = "../../Module/azurerm_nsg"
  depends_on = [module.rg]
  nsg = {
    ni = {
      name                = "cdnsg"
      location            = "east us"
      resource_group_name = "cdrg"
    }
  }
  security_rules = {
    s1 = {
      name                       = "nsgrule"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "88"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

# module "vm" {
#   source = "../../Module/azurerm_linux_virtual_machine"
#   cdvm = {
#     vm1 = {
#       name                = "cdvm"
#       resource_group_name = "cdrg"
#       location            = "Canada Central"
#       size                = "Standard_D2s_v3"

#       caching              = "ReadWrite"
#       storage_account_type = "Standard_LRS"

#       publisher = "Canonical"
#       offer     = "0001-com-ubuntu-server-focal"
#       sku       = "20_04-LTS"
#       version   = "latest"
#     }
#   }
# }
