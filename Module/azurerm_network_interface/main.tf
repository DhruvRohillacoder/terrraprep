resource "azurerm_network_interface" "nic" {
  for_each = var.nic

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = var.ip_configuration
    content {
      name                          = ip_configuration.value.name
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }
}
output "nic_ids" {
  description = "NIC IDs"
  value = {
    for k, n in azurerm_network_interface.nic : k => n.id
  }
}

