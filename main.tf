output "output_database_details" {
  value = local.database_details
}

resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = local.resource_location
}


resource "azurerm_mssql_server" "sqlserver" {
  for_each = var.dbapp_environment.production.server
  name                         = each.key
  resource_group_name          = azurerm_resource_group.appgrp.name
  location                     = local.resource_location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "Azure@3456"
}

resource "azurerm_mssql_database" "app_db" {
  for_each = { for detail in local.database_details: detail.database_name=>detail}
  name         = each.key
  server_id    = azurerm_mssql_server.sqlserver["${each.value.server_name}"].id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = each.value.database_sku
  sample_name = each.value.database_sampledb
}

resource "azurerm_mssql_firewall_rule" "allowmyClient" {
  for_each = var.dbapp_environment.production.server
  name             = "AllowClientIp"
  server_id        = azurerm_mssql_server.sqlserver["${each.key}"].id
  start_ip_address = "87.163.227.189"
  end_ip_address   = "87.163.227.189"
}

resource "null_resource" "database_setup" {
  provisioner "local-exec" {
    sqlcmd
  }
}