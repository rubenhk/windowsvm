locals {
  rebuildtags = {
    VMType         = var.VMType
    RebuildDueDate = var.RebuildDueDate
  }
}

resource "random_password" "password" {
  length           = 25
  special          = true
  override_special = "_%@$"
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                       = var.vm_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  size                       = var.vm_size
  admin_username             = var.vm_admin_username
  admin_password             = random_password.password.result
  zone                       = var.zone
  encryption_at_host_enabled = var.encryption_at_host_enabled

  tags = merge(var.tags, local.rebuildtags)

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
    disk_encryption_set_id = var.disk_encryption_set_id
  }


  dynamic "source_image_reference" {
    for_each = var.source_image_id == "marketplaceimage" ? [1] : []

    content {
      publisher = var.image_publisher
      offer     = var.image_offer
      sku       = var.image_sku
      version   = var.image_version
    }
  }

  source_image_id = var.source_image_id == "marketplaceimage" ? null : var.source_image_id

  dynamic "identity" {
    for_each = var.SystemAssignedIdentity == true ? [1] : []

    content {
      type = "SystemAssigned"
    }
  }


  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, tags are updated and set based on azure polocy 
      tags
    ]
  }
}
