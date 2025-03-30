dbapp_environment = {
  production={
    server={
      sqlserver400908099={
        databases={
          appdb={
            sku="S0"
            sampledb=null
          }
          adventureworksdb={
            sku="S0"
            sampledb="AdventureWorksLT"
          }
        }
      }
    }
  }
}
app_setup = ["sqlserver400908099", "appdb"]