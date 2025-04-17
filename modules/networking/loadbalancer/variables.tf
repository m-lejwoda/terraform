variable "resource_group_name" {
  type=string
  description = "This defines the name of the resource group"
}

variable "location" {
  type=string
  description = "This defines the location of the resources"
}
variable "number_of_machines" {
  type = number
  description = "These are the number of machines in the backend pool of the Load Balancer"
}

variable "network_interface_private_ip_address" {
  type = list(string)
  description = "This is the private Ip addresses of tthe network interfaces attached to"
}

variable "virtual_network_id" {
  type = string
  description = "This is the resource id of the virtual network"
}