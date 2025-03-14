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

  # subnet {
  #   name             = local.subnets[0].name
  #   address_prefixes = [local.subnets[0].address_prefix]
  # }
  #
  # subnet {
  #   name             = local.subnets[1].name
  #   address_prefixes = [local.subnets[1].address_prefix]
  #   # security_group   = azurerm_network_security_group.example.id
  # }



  # tags = {
  #   environment = "Production"
  # }
}

resource "azurerm_subnet" "websubnet01" {
  name                 = local.subnets[0].name
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = [local.subnets[0].address_prefix]

}


resource "azurerm_subnet" "appsubnet01" {
  name                 = local.subnets[1].name
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes     = [local.subnets[1].address_prefix]


}

resource "azurerm_network_interface" "webinterface01" {
  name                = "webinterface01"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.websubnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.webip01.id
  }
}

resource "azurerm_public_ip" "webip01" {
  allocation_method   = "Static"
  location            = local.resource_location
  name                = "webip01"
  resource_group_name = azurerm_resource_group.appgrp.name
}

# output "websubnet_01"{
#   value = azurerm_subnet.websubnet01.id
# }
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
