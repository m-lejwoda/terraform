resource "azurerm_storage_account" "appstore43438978439923" {
  name = "appstore43438978439923"
  resource_group_name = azurerm_resource_group.appgrp.name
  location = local.resource_location
  account_tier = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
}

resource "azurerm_storage_container" "weblogs" {
  name="weblogs"
  storage_account_name = azurerm_storage_account.appstore43438978439923.name
  container_access_type = "blob"
}
data "azurerm_storage_account_blob_container_sas" "accountsas"{
  connection_string = azurerm_storage_account.appstore43438978439923.primary_connection_string
  container_name = azurerm_storage_container.weblogs.name
  https_only = true

  start = "2025-03-25"
  expiry = "2025-03-31"
  permissions {
    add    = true
    create = false
    delete = true
    list   = true
    read   = true
    write  = true
  }
}