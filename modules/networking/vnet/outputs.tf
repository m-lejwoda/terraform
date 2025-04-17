output "virtual_network_interfaces_ids" {
  value = azurerm_network_interface.network_interfaces[*].id
}