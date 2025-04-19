

module "resource-group" {
    source = "./modules/general/resourcegroup"
    resource_group_name = var.resource_group_name
    location = var.location
}   

module "network" {
   source="./modules/networking/vnet"
   resource_group_name = var.resource_group_name
   location = var.location
   network_security_group_rules = var.network_security_group_rules
   subnet_details = local.subnet_details
   virtual_network_details = local.virtual_network_details
   network_interface_details = local.network_interface_details
   depends_on = [ module.resource-group ]
}


module "virtual-machines" {    
    source="./modules/compute/virtualMachines"
    resource_group_name=var.resource_group_name
    location=var.location
    virtual_machine_details = local.virtual_machine_details
    network_interface_details = local.network_interface_details
    storage_account_name = module.storage-account.storage_account_name
    container_name = "scripts"
    depends_on = [ module.network,module.storage-account ]
}

module "storage-account" {
    source = "./modules/storage/azurestorage"
    resource_group_name = var.resource_group_name
    location = var.location
    storage_account_details = var.storage_account_details
    container_names = var.container_names
    blobs = var.blobs
    depends_on = [ module.resource-group ]
}