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
  subscription_id = "05f4e3ca-9790-4083-8531-f315f2fd6ebc"
}

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "Poland Central"
}