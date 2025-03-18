resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "Poland Central"
}

resource "azurerm_virtual_network" "app_network" {
  name                = local.virtual_network.name
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space       = local.virtual_network.address_prefixes
}

resource "azurerm_subnet" "app_network_subnets" {
  for_each = var.subnet_information
  name                 = each.key
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = [each.value.cidrblock]
}

resource "azurerm_network_interface" "assignment_inteface" {
  count               = var.network_inteface_count
  name                = "webinterface0${count.index + 1}"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_network_subnets["websubnet01"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webip[count.index].id
  }
}

resource "azurerm_public_ip" "webip" {
  count               = var.network_inteface_count
  location            = local.resource_location
  name                = "webip0${count.index + 1}"
  resource_group_name = azurerm_resource_group.appgrp.name
  allocation_method   = "Static"
}

# output "container_name" {
#   value = azurerm_storage_container.scripts["data"].name
# }

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