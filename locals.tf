locals {
  resource_location = "West Europe"
  networksecuritygroup_rules=[{
    priority=300
    destination_port_range="22"
  }]
}