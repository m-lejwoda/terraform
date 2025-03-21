resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}


resource "azurerm_virtual_network" "app_network" {
  address_space = [var.app_environment.production.virtualnetworkcidrblock]
  location            = local.resource_location
  name                = var.app_environment.production.virtualnetworkname
  resource_group_name = azurerm_resource_group.appgrp.name
}

resource "azurerm_subnet" "app_network_subnets" {
  for_each             = var.app_environment.production.subnets
  address_prefixes = [each.value.cidrblock]
  name                 = each.key
  resource_group_name  = azurerm_resource_group.appgrp.name
  virtual_network_name = azurerm_virtual_network.app_network.name
}

resource "azurerm_network_interface" "webinterfaces" {
  name                = var.app_environment.production.networkinterfacename
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_network_subnets["websubnet01"].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webip.id
  }
}

resource "azurerm_public_ip" "webip" {
  allocation_method   = "Static"
  location            = local.resource_location
  name                = var.app_environment.production.publicipaddressname
  resource_group_name = azurerm_resource_group.appgrp.name
}

resource "azurerm_network_security_group" "app_nsg" {
  name                = "app-nsg"
  location            = local.resource_location
  resource_group_name = azurerm_resource_group.appgrp.name

  dynamic security_rule {
    for_each = local.networksecuritygroup_rules
    content {
      name                       = "Allow-${security_rule.value.destination_port_range}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet_appnsg" {
  for_each                  = azurerm_subnet.app_network_subnets
  subnet_id                 = azurerm_subnet.app_network_subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_windows_virtual_machine" "webvm" {
  admin_password = azurerm_key_vault_secret.vmpassword.value
  admin_username = "appadmin"
  location       = local.resource_location
  name           = var.app_environment.production.virtualmachinename
  network_interface_ids = [
    azurerm_network_interface.webinterfaces.id
  ]
  resource_group_name               = azurerm_resource_group.appgrp.name
  size                              = "Standard_B2s"
  vm_agent_platform_updates_enabled = true
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "WindowsServer"
    publisher = "MicrosoftWindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

}