locals {
  resource_location="West Europe"
  database_details= (flatten([
    for server_key, server in var.dbapp_environment.production.server : [
      for database_key, database in server.databases :{
        server_name       = server_key
        database_name     = database_key
        database_sku      = database.sku
        database_sampledb = database.sampledb
      }
    ]
  ])
  )

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
#
# locals {
#   resource_location="Poland Central"
#   production_tags = {
#     production_code="${var.resource_tags.tags.department} ${var.resource_tags.tags.tier}-"
#     production_tier="${var.resource_tags.tags.tier}"
#   }
# }