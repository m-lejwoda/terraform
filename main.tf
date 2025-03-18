resource "azurerm_resource_group" "appgrp" {
  name     = "app-grp"
  location = "Poland Central"
}



resource "azurerm_storage_account" "appstorageaccount123" {
  # count = 3
  name = "appstoreage40412331"
  resource_group_name = azurerm_resource_group.appgrp.name
  location = azurerm_resource_group.appgrp.location
  account_tier = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "scripts" {
  for_each = toset(["data", "scripts", "logs"])
  name                 = each.key
  storage_account_name = azurerm_storage_account.appstorageaccount123.name
}

resource "azurerm_storage_blob" "scripts" {
  for_each = tomap({
    script01 = "qaksk2s6vp8gszbc10202tjzt.png"
    script02 = "qaksk2s6vp8gszbc10202tjzt1.png"
    script03 = "qaksk2s6vp8gszbc10202tjzt2.png"
  })
  name                   = "${each.key}.png"
  storage_account_name   = azurerm_storage_account.appstorageaccount123.name
  storage_container_name = azurerm_storage_container.scripts["scripts"].name
  type                   = "Block"
  source = each.value
}

# output "container_name" {
#   value = azurerm_storage_container.scripts["data"].name
# }

# resource "azurerm_storage_account" "appstorageaccount1235" {
#   name = "appstoreage4041233551"
#   resource_group_name = azurerm_resource_group.appgrp.name
#   location = azurerm_resource_group.appgrp.location
#   account_tier = "Standard"
#   account_replication_type = "LRS"
# }
#
# resource "azurerm_storage_container" "scripts" {
#   count = 3
#   name                  = "scripts${count.index}"
#   storage_account_id    = azurerm_storage_account.appstorageaccount1235.id
#   container_access_type = "private"
# }