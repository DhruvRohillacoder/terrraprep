variable "cdvm" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    location             = string
    size                 = string
    caching              = string
    storage_account_type = string

    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))
}