resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}


resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
}

resource "azurerm_virtual_network" "app_network" {
  name                = local.virtual_network.name
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space       = local.virtual_network.address_prefixes
  # dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "websubnet01"
    address_prefixes = [local.subnet_address_prefix[0]]
  }

  subnet {
    name             = "appsubnet01"
    address_prefixes = [local.subnet_address_prefix[1]]
    # security_group   = azurerm_network_security_group.example.id
  }

  # tags = {
  #   environment = "Production"
  # }
}

# resource "azurerm_storage_account" "appstore09090894343" {
#   name                     = "appstore09090894343"
#   resource_group_name      = azurerm_resource_group.appgrp.name
#   location                 = azurerm_resource_group.appgrp.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#
# }
# resource "azurerm_storage_container" "scripts" {
#   name                  = "scripts"
#   storage_account_name  = azurerm_storage_account.appstore09090894343.name
#
# }
#
# resource "azurerm_storage_blob" "qaksk2s6vp8gszbc10202tjzt" {
#   name                   = "qaksk2s6vp8gszbc10202tjzt.png"
#   storage_account_name   = azurerm_storage_account.appstore09090894343.name
#   storage_container_name = azurerm_storage_container.scripts.name
#   type                   = "Block"
#   source                 = "qaksk2s6vp8gszbc10202tjzt.png"
# }
#
