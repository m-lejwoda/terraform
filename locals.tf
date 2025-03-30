locals {
  resource_location = "West Europe"
  networksercuritygroup_rules=[{
    priority=300
    destination_port_range="22"
  }]
}