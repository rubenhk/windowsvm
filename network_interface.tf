resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.nic_ip_allocation_type
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure polocy 
      tags
    ]
  }
}
