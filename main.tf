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
  for_each             = var.subnet_information
  name                 = each.key
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
  address_prefixes = [each.value.cidrblock]
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
    public_ip_address_id          = azurerm_public_ip.webip[count.index].id
  }
}

resource "azurerm_public_ip" "webip" {
  count               = var.network_inteface_count
  location            = local.resource_location
  name                = "webip0${count.index + 1}"
  resource_group_name = azurerm_resource_group.appgrp.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "app_nsg" {
  name = "app-nsg"
  location = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_appnsg" {
  for_each                  = azurerm_subnet.app_network_subnets
  subnet_id                 = azurerm_subnet.app_network_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.app_nsg.id

}

resource "azurerm_windows_virtual_machine" "webvm" {
  count=var.network_inteface_count
  name = "webvm0${count.index}"
  resource_group_name = azurerm_resource_group.appgrp.name
  location= local.resource_location
  size = "Standard_B2s"
  admin_username = "appadmin"
  admin_password = "Azure@123"
  vm_agent_platform_updates_enabled = true
  availability_set_id = azurerm_availability_set.appset.id
  network_interface_ids = [
    azurerm_network_interface.assignment_inteface[count.index].id
  ]
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
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