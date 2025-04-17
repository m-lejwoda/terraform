resource "azurerm_virtual_network" "virtual_network" {
  name= var.vnet_name
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = [var.vnet_address_prefix]
}

resource "azurerm_subnet" "network_subnets" {
  count = var.vnet_subnet_count
  name = "subnet${count.index}"
  resource_group_name = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [cidrsubnet(var.vnet_address_prefix, 8, count.index )]
}

resource "azurerm_public_ip" "public_ipaddress" {
  count=var.public_ip_address_count
  location            = var.location
  name                = "public-ip0${count.index+1}"
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "network_interfaces" {
  count=var.network_interfaces_count
  location            = var.location
  name                = "interface-0${count.index+1}"
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id = azurerm_subnet.network_subnets[count.index].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ipaddress[count.index].id
  }
}