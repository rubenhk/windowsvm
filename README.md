# Azure Virtual Machine

This module provisions windows/linux VM

## Required input variables

* `resource_group_name` - The name of the resource group in which to create the virtual machine scale set
* `location` - The location for the virtual machine
* `subnet_id` - The subnet ID for the VM to be deployed to (Data block)
* `vm_name` - The name of the VM to be assigned.
* `vm_size` - The SKU which should be used for this Virtual Machine, such as Standard_F2
* `vm_admin_username` - The subnet ID for the VM to be deployed to (Data block)
* `image_publisher` - Specifies the publisher of the image used to create the virtual machines.
* `image_offer` - Specifies the offer of the image used to create the virtual machines.
* `image_sku` - Specifies the SKU of the image used to create the virtual machines.
* `image_version` - Specifies the version of the image used to create the virtual machines.
* `subnet_id` - Specifies the subnet to accomodate the VM.
* `disk_encryption_set_id` - The ID of the disk encryption set to encrypt at host

## Optional input variables

* `nic_ip_allocation_type` - The allocation method used for the Private IP Address. Possible values are Dynamic and Static. Defaults to Static
* `is_vdi` - for VM to join a hostpool
* `hostpool_name` - Name of hostpool to be joined
* `domain_name` - Name of domian for VM to join
* `domain_password` - Password for the domaim joining
* `ou_path` - domian OU path
* `domain_user_upn` - domian user upn
* `tenant_app_id` - tenant app id
* `tenant_app_password` - tenant app password
* `existing_tenant_group_name` - tenant group name
* `tenant_name` - tenant name
* `registration_expiration_hours` - time for the registration to expire
* `is_service_principal` - if a service principle is being used to join the hostpool
* `aad_tenant_id` - tenant id
* `encryption_at_host_enabled` - Should we encrypt the VM? Defaults to false for now

## To do 
- Set to  "should we encrypt" as default True once all extant WVDs are encrypted

## To use (includes SSH key resource):
- You will need the following: 
1. resource group 
2. vnet
3. subnet
4. Image details either marketplace image details or shared gallery image details
5. Password/ssh-keyfile already generated/stored in key vault etc. and ready to use.

```
module "vm" {
  source = "https://KulaKeepUK@dev.azure.com/KulaKeepUK/CloudServices/_git/kk.terraform.module.vm"
  # Below are variables within the module on the left, and on the right hand side is where you assign them.
  location               = "North Europe"
  resource_group_name    = "azurerm_resource_group.rg.name"
  subnet_id              = data.azurerm_subnet.subnet.id
  vm_name                = "name of the VM as per policy"
  vm_size                = "Standard_f2"
  vm_admin_username      = "azureuser"
  image_publisher        = "Canonical"
  image_offer            = "UbuntuServer"
  image_sku              = "16.04-LTS"
  image_version          = "latest"
  nic_ip_allocation_type = "Dynamic"

  # Below variables are needed if the VM is being used as VDI to join a hostpool.
  is_vdi                        = true
  hostpool_name                 = "hostpool name"
  domain_name                   = "domain for VM to join"
  domain_password               = "password for the domaim joining"
  ou_path                       = "domian OU path"
  domain_user_upn               = "domian user upn"
  tenant_app_id                 = "tenant app id"
  tenant_app_password           = "tenant app password"
  existing_tenant_group_name    = "tenant group name"
  tenant_name                   = "tenant name"
  registration_expiration_hours = "48"
  is_service_principal          = true
  aad_tenant_id                 = "tenant id"
}

```
