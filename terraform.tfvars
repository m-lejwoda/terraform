webapp_environment = {
  production = {
    serviceplan={
      serviceplan5034543={
        sku="S1"
        os_type="Windows"
      }
    }
    serviceapp={
      webapp034356="serviceplan5034543"
    }
  }
}
resource_tags ={
  "tags" = {
    department = "logisticks"
    tier = "Tier2"
  }}

webapp_slot = ["webapp034356", "staging"]