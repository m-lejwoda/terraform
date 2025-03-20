# vm_name="webvm01"
# admin_username="appadmin"
#
# network_inteface_count = 2

app_environment = {
  production = {
    virtualnetworkname      = "app-network"
    virtualnetworkcidrblock = "10.0.0.0/16"

    subnets = {
      websubnet01 = { cidrblock = "10.0.0.0/24" }
      appsubnet01 = { cidrblock = "10.0.1.0/24" }
    }
    networkinterfacename = "webinterface01"
    publicipaddressname = "webip01"
    virtualmachinename  = "webvm01"
  }
}
