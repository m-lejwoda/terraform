resource "azurerm_linux_virtual_machine_scale_set" "scaleset" {
  name                = "app-scaleset-2000"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard_B1s"
  instances           = 2
  admin_username      = "linuxadmin"
  admin_password = "Azure@123"
  disable_password_authentication = false
  custom_data = data.local_file.cloudinit.content_base64

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "scalesetinterface"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.virtual_network_subnet_ids[0]
      load_balancer_backend_address_pool_ids = [var.virtual_machine_pool_id]
    }
  }
}

data "local_file" "cloudinit" {
  filename = "./modules/compute/scalesets/cloudinit"
}