module "resource-group" {
  source = "./modules/general/resourcegroup"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "network" {
  source="./modules/networking/vnet"
  resource_group_name = var.resource_group_name
  location = var.location
  vnet_name = var.vnet_name
  vnet_address_prefix = var.vnet_address_prefix
  vnet_subnet_count = var.vnet_subnet_count
  public_ip_address_count = var.public_ip_address_count
  network_interfaces_count = var.network_interfaces_count
  network_security_group_rules = var.network_security_group_rules
  depends_on = [module.resource-group]
}

