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


