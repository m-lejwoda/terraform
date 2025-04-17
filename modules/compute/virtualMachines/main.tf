resource "azurerm_linux_virtual_machine" "appvm" {
  count = var.virtual_machine_count
  admin_password = "Azure@123"
  admin_username = "appadmin"
  location       = var.location
  name           = "webvm0${count.index+1}"
  resource_group_name = var.resource_group_name
  disable_password_authentication = false
  size                = "Standard_B1s"
  custom_data = data.local_file.cloudinit.content_base64
  vm_agent_platform_updates_enabled = true
    network_interface_ids = [
    var.virtual_network_interface_ids[count.index]
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts"
    version   = "latest"
  }

}
data "local_file" "cloudinit" {
  filename = "./modules/compute/virtualMachines/cloudinit"
}