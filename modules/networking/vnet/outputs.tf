output "virtual_network_interfaces_ids" {
  value = azurerm_network_interface.network_interfaces[*].id
}

output "public_ip_addresses"{
  value=azurerm_public_ip.public_ipaddress[*].ip_address
}