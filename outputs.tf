output "vm_ip" {
  value = azurerm_network_interface.nic.private_ip_address
}

output "vm" {

  value = azurerm_windows_virtual_machine.vm
}
