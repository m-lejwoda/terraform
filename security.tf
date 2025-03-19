resource "azurerm_key_vault" "appvault498943784353" {
  name                        = "appvault498943784353"
  location                    = local.resource_location
  resource_group_name         = azurerm_resource_group.appgrp.name
  tenant_id                   = "eb02fdd8-18ac-4595-9ca0-ea873499cb06"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  sku_name = "standard"
}