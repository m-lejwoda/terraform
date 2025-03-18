resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "Poland Central"
}



resource "azurerm_storage_account" "appstorageaccount123" {
  count = 3
  name = "${count.index}appstoreage40412331"
  resource_group_name = azurerm_resource_group.appgrp.name
  location = azurerm_resource_group.appgrp.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}

# resource "azurerm_storage_account" "appstorageaccount1235" {
#   name = "appstoreage4041233551"
#   resource_group_name = azurerm_resource_group.appgrp.name
#   location = azurerm_resource_group.appgrp.location
#   account_tier = "Standard"
#   account_replication_type = "LRS"
# }
#
# resource "azurerm_storage_container" "scripts" {
#   count = 3
#   name                  = "scripts${count.index}"
#   storage_account_id    = azurerm_storage_account.appstorageaccount1235.id
#   container_access_type = "private"
# }