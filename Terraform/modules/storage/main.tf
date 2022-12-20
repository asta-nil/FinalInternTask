resource "azurerm_storage_account" "toohes_storage" {
  name                     = "${var.prefix}nfstorage"
  resource_group_name      = var.rgroup.name
  location                 = var.rgroup.location
  account_kind             = var.account_kind
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  lifecycle {
    prevent_destroy        = true
 }
}

resource "azurerm_storage_container" "toohes_st_container" {
  name                  = "${var.prefix}tfstate"
  storage_account_name  = azurerm_storage_account.toohes_storage.name
  container_access_type = var.container_access_type
   
  lifecycle {
    prevent_destroy     = true
  }
}
