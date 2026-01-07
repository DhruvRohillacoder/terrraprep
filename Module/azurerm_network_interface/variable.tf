variable "nic" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string

  }))
}

variable "ip_configuration" {
  type = map(object({
    name                          = string
    private_ip_address_allocation = string
    subnet_id                     = string
    public_ip_address_id          = optional(string)
  }))
}

