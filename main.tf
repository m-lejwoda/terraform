resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}


resource "azurerm_storage_account" "appstore40009078" {
  name = "appstore400009078"
  resource_group_name = "app-grp"
  location = "Poland Central"
  account_tier = "Standard"
  account_replication_type = "LRS"
}