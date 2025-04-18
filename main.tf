

module "resource-group" {
    source = "./modules/general/resourcegroup"
    resource_group_name = var.resource_group_name
    location = var.location
}   

module "network" {
   source="./modules/networking/vnet"
   for_each = var.environment
   resource_group_name = var.resource_group_name
   location = var.location
   vnet_name = each.value.virtual_network_name
   vnet_address_prefix = each.value.virtual_network_address_space
   vnet_subnet_count = each.value.subnet_count
   public_ip_address_count = each.value.public_ip_address_count
   network_interfaces_count = each.value.network_interface_count
   network_security_group_rules = var.network_security_group_rules 
   resource_prefix=each.key  
   depends_on = [ module.resource-group ]
}


module "virtual-machines" {
    for_each = var.environment
    source="./modules/compute/virtualMachines"
    resource_group_name=var.resource_group_name
    location=var.location
    virtual_machine_count = each.value.virtual_machine_count
    virtual_network_interface_ids = module.network[each.key].virtual_network_interfaces_ids
    virtual_machine_public_ip_addresses = module.network[each.key].public_ip_addresses
    resource_prefix=each.key
}

module "vnet-peering" {
  source = "./modules/networking/vnetpeering"
  for_each = var.peering_virtual_networks
  resource_group_name=var.resource_group_name
  source_network_name = each.key
  destination_vnet_name = each.value.destination_vnet_name
  destination_network_id = module.network[each.value.virtual_network_key].virtual_network_id
  depends_on = [ module.network ]
}