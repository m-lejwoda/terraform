locals {
  resource_location="Poland Central"
  networksecuritygroup_rules=[
    {
      priority=300
      destination_port_range="3389"
    },{
      priority=310
      destination_port_range="80"
    },
    {
      priority=320
      destination_port_range="22"
    }

  ]
  virtual_network= {
    name = "app-network"
    address_prefixes = ["10.0.0.0/16"]

  }
  # subnet_address_prefix=["10.0.1.0/24","10.0.2.0/24"]
  # subnets=[{
  #   name= "websubnet01"
  #   address_prefix = "10.0.1.0/24"
  # },{
  #   name="appsubnet01"
  #   address_prefix = "10.0.2.0/24"
  # }]
}
