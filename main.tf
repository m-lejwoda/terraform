resource "azurerm_resource_group" "appgrp"{
  name="app-grp"
  location = local.resource_location
}

resource "azurerm_virtual_network" "app_network" {
  name= var.app_environment.production.virtualnetworkname
  location = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space = [var.app_environment.production.virtualnetworkcidrblock]
}

resource "azurerm_subnet" "app_network_subnets" {
  for_each = var.app_environment.production.subnets
  name = each.key
  resource_group_name = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes = [each.value.cidrblock]
}