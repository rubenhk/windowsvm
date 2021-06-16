variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual machine"
}

variable "location" {
  type        = string
  description = "The location for the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "The SKU which should be used for this Virtual Machine, such as Standard_F2"
}

variable "vm_admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
}

variable "image_publisher" {
  type        = string
  description = "Specifies the publisher of the image used to create the virtual machines."
  default     = "MicrosoftWindowsDesktop"
}

variable "image_offer" {
  type        = string
  description = "Specifies the offer of the image used to create the virtual machines."
  default     = "Windows-10"
}

variable "image_sku" {
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machines."
  default     = "19h2-evd"
}

variable "image_version" {
  type        = string
  description = "Specifies the version of the image used to create the virtual machines."
  default     = "latest"
}

variable "subnet_id" {
  type        = string
  description = "Specifies the subnet to accomodate the VM."
}

variable "nic_ip_allocation_type" {
  type        = string
  description = "The allocation method used for the Private IP Address. Possible values are Dynamic and Static."
  default     = "Dynamic"
}

variable "is_vdi" {
  type        = bool
  description = "If the module is called to add VM to hostpool, then set this variable to true"
  default     = "true"
}

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine being created"
  default     = "static"
}

variable "domain_name" {
  description = "Name of the domain to join"
  default     = ""
}

variable "domain_password" {
  description = "**OPTIONAL**: Password of the user to authenticate with the domain"
  default     = ""
}

variable "ou_path" {
  description = "OU path to us during domain join"
  default     = ""
}

variable "domain_user_upn" {
  description = "**OPTIONAL**: UPN of the user to authenticate with the domain"
  default     = ""
}


variable "hostpool_name" {
  description = "**OPTIONAL**: The name of hostpool this VDI should join"
  default     = ""
}

variable "region_mapping" {
  description = "mapping for cross-region replication"
  default = {
    "westus"        = "true",
    "westus2"       = "true",
    "eastus"        = "true",
    "eastus2"       = "true",
    "westcentralus" = "true",
    "canadacentral" = "true",
    "canadaeast"    = "true",
    "francecentral" = "true",
    "westeurope"    = "true",
    "northeurope"   = "true",
    "japanwest"     = "true",
    "japaneast"     = "true"
  }
}

variable "zone" {
  default = 1
}


variable "artifactsLocation" {
  type    = string
  default = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_12-15-2020.zip"
}

variable "registrationInfoToken" {
  type    = string
  default = "invalidcode"
}


variable "source_image_id" {
  type    = string
  default = "marketplaceimage"
}

variable "VMType" {
  type    = string
  default = ""
}

variable "RebuildDueDate" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "SystemAssignedIdentity" {
  type    = bool
  default = true
}

variable "encryption_at_host_enabled" {
  type    = bool
  default = false
}

variable "disk_encryption_set_id" {
  description = "ID of Disk Encryption Set - Required for Encryption at Host"
  type        = string
  default     = null
}
