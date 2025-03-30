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

webapp_environment = {
  production={
    serviceplan={
      serviceplan2334238945={
        sku="B1"
        os_type="Windows"
      }
    }
    serviceapp={
      webapp55000400301="serviceplan2334238945"
    }
  }
}