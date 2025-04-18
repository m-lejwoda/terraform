resource "azurerm_public_ip" "loadip" {
  name                = "load-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku = "Standard"
}


resource "azurerm_lb" "appbalancer" {
  name = "app-balancer"
  location = var.location
  resource_group_name = var.resource_group_name
  sku = "Standard"
  sku_tier = "Regional"
  frontend_ip_configuration {
    name = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.loadip.id
  }
}

resource "azurerm_lb_backend_address_pool" "virtual_machine_pool" {
  loadbalancer_id = azurerm_lb.appbalancer.id
  name            = "VirtualMachinePool"
}

resource "azurerm_lb_backend_address_pool_address" "appvmaddress" {
  count=var.number_of_machines
  name            = "machine${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.virtual_machine_pool.id
  virtual_network_id = var.virtual_network_id
  ip_address = var.network_interface_private_ip_address[count.index]
}

resource "azurerm_lb_probe" "probeA" {
  loadbalancer_id = azurerm_lb.appbalancer.id
  name="probeA"
  port=80
  protocol="Tcp"
}

resource "azurerm_lb_rule" "RuleA" {
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  frontend_port                  = 80
  loadbalancer_id                = azurerm_lb.appbalancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  probe_id = azurerm_lb_probe.probeA.id
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.virtual_machine_pool.id]
}