terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

    backend "azurerm" {
    resource_group_name  = "moon-rg"
    storage_account_name = "moonnfstorage"
    container_name       = "moontfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
