resource "azurerm_virtual_machine_extension" "domainJoin" {
  count                      = var.is_vdi ? 1 : 0
  name                       = "${var.vm_name}-domainjoin"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_windows_virtual_machine.vm]

  lifecycle {
    ignore_changes = [
      settings,
      protected_settings,
      tags
    ]
  }

  settings = <<SETTINGS
    {
        "Name": "${var.domain_name}",
        "OUPath": "${var.ou_path}",
        "User": "${var.domain_user_upn}@${var.domain_name}",
        "Restart": "true",
        "Options": "3"
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
         "Password": "${var.domain_password}"
  }
PROTECTED_SETTINGS

}


resource "azurerm_virtual_machine_extension" "additional_session_host_dscextension" {
  count                      = var.is_vdi ? 1 : 0
  name                       = "${var.vm_name}-wvd_dsc"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true
  depends_on                 = [azurerm_virtual_machine_extension.domainJoin]

  settings = <<SETTINGS
{
    "modulesURL": "${var.artifactsLocation}",
    "configurationFunction": "Configuration.ps1\\AddSessionHost",
     "properties": {
        "hostPoolName": "${var.hostpool_name}",
        "registrationInfoToken": "${var.registrationInfoToken}"
      }
}
SETTINGS

  lifecycle {
    ignore_changes = [
      settings,
      tags
    ]
  }
}
