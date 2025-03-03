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