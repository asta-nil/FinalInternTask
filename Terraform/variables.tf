#============= GENERALL =============#

variable "rgroup" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource Group"
}

variable "prefix" {
  type        = string
  description = "Project name"
}

#============= NETWORK =============#

variable "vnet_adspace" {
  type        = list(string)
  description = "Vnet address space"
}

variable "subnet_adspace" {
  type        = list(string)
  description = "Subnet addres space"
}

variable "public_ip" {
  type = object({
    allocation_method = string
    version           = string
    sku               = string
  })
  description = "IP address"
}

variable "nsgrule" {
  type = list(object({
    name                       = string
    priority                   = number
    destination_port_range     = string
    direction                  = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    access                     = string
  }))
  description = "NSG rules"
}
#================ VM ================#
variable "vm" {
  type = object({
    image = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    disk = object({
      name                 = string
      caching              = string
      storage_account_type = string
    })
  })
  description = "Basic settings for VM"
}

variable "size" {
  type        = string
  description = "VM size"
}

variable "admin_username" {
  type        = string
  description = "VM username"
}

variable "public_key" {
  type        = string
  sensitive   = true
  description = "SSH Public Key"
}

#============== STORAGE ==============#

variable "account_kind" {
  type        = string
  description = "Storage account kind"
}

variable "account_tier" {
  type        = string
  description = "Storage account tier"
}

variable "account_replication_type" {
  type        = string
  description = "Storage account replication type"
}

variable "container_access_type" {
  type        = string
  description = "Storage container access type"
}
