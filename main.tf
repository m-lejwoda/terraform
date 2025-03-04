terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.21.1"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  client_id = "968f84f8-8627-480d-96e3-f6b72b529969"
  client_secret = "WAK8Q~uzhzif2aEeP3ql_bYg-Ghnn_x1MzTXiaTK"
  tenant_id = "eb02fdd8-18ac-4595-9ca0-ea873499cb06"
  subscription_id = "05f4e3ca-9790-4083-8531-f315f2fd6ebc"
}

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "Poland Central"
}

resource "azurerm_storage_account" "appstore09090894343" {
  name                     = "appstore09090894343"
  resource_group_name      = azurerm_resource_group.appgrp.name
  location                 = azurerm_resource_group.appgrp.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}
resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_name  = azurerm_storage_account.appstore09090894343.name

}

resource "azurerm_storage_blob" "qaksk2s6vp8gszbc10202tjzt" {
  name                   = "qaksk2s6vp8gszbc10202tjzt.png"
  storage_account_name   = azurerm_storage_account.appstore09090894343.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "qaksk2s6vp8gszbc10202tjzt.png"
}