# resource "azurerm_availability_set" "appset" {
#   name                = "appset"
#   location            = local.resource_location
#   resource_group_name = azurerm_resource_group.appgrp.name
#   platform_fault_domain_count = 2
#   platform_update_domain_count = 2
#
# }