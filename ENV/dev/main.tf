#####################################
# RESOURCE GROUP MODULE
#####################################
module "rg" {
  source = "../../Module/rg"

  rg = {
    r1 = {
      name     = "cdrg"
      location = "Central India"
    }
  }
}

#####################################
# VIRTUAL NETWORK MODULE
#####################################
module "vnet" {
  source = "../../Module/azurerm_vnet"

  # RG pe depend karta hai
  depends_on = [module.rg]

  vnet = {
    v1 = {
      name                = "cdvnet"
      location            = "Central India"
      resource_group_name = "cdrg"
      address_space       = ["10.0.0.0/16"]
    }
  }
}

#####################################
# SUBNET MODULE
#####################################
module "subnet" {
  source = "../../Module/azurerm_subnet"

  # VNet pe depend karta hai
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

#####################################
# PUBLIC IP MODULE
#####################################
module "pip" {
  source = "../../Module/azurerm_public_ip"

  depends_on = [module.rg]

  pip = {
    p1 = {
      name                = "cdpip"
      resource_group_name = "cdrg"
      location            = "Central India"
      allocation_method   = "Static"
      sku                 = "Standard"
    }
  }
}

#####################################
# NETWORK INTERFACE MODULE
#####################################
module "nic" {
  source = "../../Module/azurerm_network_interface"

  # NIC basic config
  nic = {
    nic1 = {
      name                = "cdnic"
      location            = "Central India"
      resource_group_name = "cdrg"
    }
  }


  # IP configuration:
  # - Subnet ID subnet module ke output se
  # - Public IP ID pip module ke output se
  ip_configuration = {
    ip_configuration1 = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
      subnet_id                     = module.subnet.subnet_ids["s1"]
      public_ip_address_id          = module.pip.pip_ids["p1"]
    }
  }
}

#####################################
# NETWORK SECURITY GROUP MODULE
#####################################
module "nsg" {
  source = "../../Module/azurerm_nsg"

  depends_on = [module.rg]

  nsg = {
    ni = {
      name                = "cdnsg"
      location            = "Central India"
      resource_group_name = "cdrg"
    }
  }

  # NSG security rules
  security_rules = {
    s1 = {
      name                       = "nsgrule"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

module "vm" {
  source = "../../Module/azurerm_linux_virtual_machine"

  vm = {
    vm1 = {
      name                = "cdvm"
      resource_group_name = "cdrg"
      size                = "Standard_D2s_v3"

      location = "Central India"



    }
  }

  network_interface_ids = [
    module.nic.nic_ids["nic1"]
  ]

  # ✅ Key Vault se values (CORRECT NAMES)
  admin_username = data.azurerm_key_vault_secret.kv_username.value
  admin_password = data.azurerm_key_vault_secret.kv_password.value

  os_disk = {
    vmos1 = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
  }

  source_image_reference = {
    vmsource1 = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-LTS"
      version   = "latest"
    }
  }
}
