variable "vm" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    size                = string
    # caching              = string
    # storage_account_type = string
    # publisher = string
    # offer                = string
    # sku                  = string
    # version = string
  }))
}

variable "os_disk" {
  type = map(object({
    caching              = string
    storage_account_type = string
  }))
}

variable "source_image_reference" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

}

variable "network_interface_ids" {
  type        = list(string)
  description = "NIC IDs to attach to VM"
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}
